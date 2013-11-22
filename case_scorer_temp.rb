require 'csv'


  def case_subscore_generator id, q_id
    return @response_hash[id.to_s()][q_id.to_s()].to_f()
  end

  def calc_weighted_score high=0, middle=0, low=0, teacher=0
    levels  = [high, middle, low, teacher]
    counts = [@hs_student_response_counts[@s_id], @ms_student_response_counts[@s_id], @elem_student_response_counts[@s_id], @teacher_response_counts[@s_id]]
    sum = 0
    counts.each{|a| sum += a.to_f()}
    if sum == 0
      return 0
    else
      m = 0
      total = 0
      pop = 0
      while m<4
        total += levels[m].to_f()*counts[m].to_f()
        if levels[m] != 0
          pop += counts[m]
        end
        m+=1
      end
      if pop == 0
        return 0
      else
        return total/pop
      end
    end
  end

  def score_classroom_teacher_assistive_tech
    @score_classroom_teacher_assistive_tech = (
      (10 * case_subscore_generator(@s_id,142)) +
      (10 * case_subscore_generator(@s_id,144)) +
      (5  * case_subscore_generator(@s_id,112)) +
      (5  * case_subscore_generator(@s_id,113)) +
      (10 * case_subscore_generator(@s_id,114)) +
      (10 * case_subscore_generator(@s_id,115)) +
      (10 * case_subscore_generator(@s_id,153)) +
      (10 * case_subscore_generator(@s_id,154)) +
      (10 * case_subscore_generator(@s_id,155)) +
      (20 * case_subscore_generator(@s_id,156))
    ) / 100
  end

  def score_classroom_teacher_assessment
   
    @score_classroom_teacher_assessment = (
      (5  * case_subscore_generator(@s_id,139)) +
      (25 * case_subscore_generator(@s_id,143)) +
      (15 * case_subscore_generator(@s_id,122)) +
      (15 * case_subscore_generator(@s_id,123)) +
      (40 * case_subscore_generator(@s_id,140))
    ) / 100
  end

  def score_classroom_teacher_4Cs
    @score_classroom_teacher_4Cs = (
      (6.25 * case_subscore_generator(@s_id,118)) +
      (6.25 * case_subscore_generator(@s_id,119)) +
      (6.25 * case_subscore_generator(@s_id,125)) +
      (6.25 * case_subscore_generator(@s_id,117)) +
      (4.5  * case_subscore_generator(@s_id,122)) +
      (4.5  * case_subscore_generator(@s_id,123)) +
      (4.5  * case_subscore_generator(@s_id,124)) +
      (4.5  * case_subscore_generator(@s_id,126)) +
      (4.5  * case_subscore_generator(@s_id,121)) +
      (2.5  * case_subscore_generator(@s_id,131)) +
      (6.25 * case_subscore_generator(@s_id,137)) +
      (6.25 * case_subscore_generator(@s_id,135)) +
      (6.25 * case_subscore_generator(@s_id,134)) +
      (6.25 * case_subscore_generator(@s_id,136)) +
      (6.25 * case_subscore_generator(@s_id,130)) +
      (6.25 * case_subscore_generator(@s_id,132)) +
      (6.25 * case_subscore_generator(@s_id,129)) +
      (6.25 * case_subscore_generator(@s_id,128))
    ) / 100
  end

  def score_classroom_student_high_4Cs
    @score_classroom_student_high_4Cs = (
      (6.25 * case_subscore_generator(@s_id,479)) +
      (6.25 * case_subscore_generator(@s_id,480)) +
      (6.25 * case_subscore_generator(@s_id,486)) +
      (6.25 * case_subscore_generator(@s_id,478)) +
      (4.5  * case_subscore_generator(@s_id,483)) +
      (4.5  * case_subscore_generator(@s_id,484)) +
      (4.5  * case_subscore_generator(@s_id,485)) +
      (4.5  * case_subscore_generator(@s_id,487)) +
      (4.5  * case_subscore_generator(@s_id,482)) +
      (2.5  * case_subscore_generator(@s_id,492)) +
      (6.25 * case_subscore_generator(@s_id,498)) +
      (6.25 * case_subscore_generator(@s_id,496)) +
      (6.25 * case_subscore_generator(@s_id,495)) +
      (6.25 * case_subscore_generator(@s_id,497)) +
      (6.25 * case_subscore_generator(@s_id,491)) +
      (6.25 * case_subscore_generator(@s_id,493)) +
      (6.25 * case_subscore_generator(@s_id,490)) +
      (6.25 * case_subscore_generator(@s_id,489))
    ) / 100
  end

  def score_classroom_student_middle_4Cs
    @score_classroom_student_middle_4Cs = (
      (6.25 * case_subscore_generator(@s_id,394)) +
      (6.25 * case_subscore_generator(@s_id,395)) +
      (6.25 * case_subscore_generator(@s_id,401)) +
      (6.25 * case_subscore_generator(@s_id,393)) +
      (4.5  * case_subscore_generator(@s_id,398)) +
      (4.5  * case_subscore_generator(@s_id,399)) +
      (4.5  * case_subscore_generator(@s_id,400)) +
      (4.5  * case_subscore_generator(@s_id,402)) +
      (4.5  * case_subscore_generator(@s_id,397)) +
      (2.5  * case_subscore_generator(@s_id,407)) +
      (6.25 * case_subscore_generator(@s_id,413)) +
      (6.25 * case_subscore_generator(@s_id,411)) +
      (6.25 * case_subscore_generator(@s_id,410)) +
      (6.25 * case_subscore_generator(@s_id,412)) +
      (6.25 * case_subscore_generator(@s_id,406)) +
      (6.25 * case_subscore_generator(@s_id,408)) +
      (6.25 * case_subscore_generator(@s_id,405)) +
      (6.25 * case_subscore_generator(@s_id,404))
    ) / 100
  end

  def score_classroom_student_elementary_4Cs
    @score_classroom_student_elementary_4Cs = (
      (9.08 * case_subscore_generator(@s_id,318)) +
      (9.08 * case_subscore_generator(@s_id,317)) +
      (7.3  * case_subscore_generator(@s_id,320)) +
      (7.3  * case_subscore_generator(@s_id,321)) +
      (7.3  * case_subscore_generator(@s_id,322)) +
      (5.3  * case_subscore_generator(@s_id,327)) +
      (9.12 * case_subscore_generator(@s_id,331)) +
      (9.12 * case_subscore_generator(@s_id,330)) +
      (9.12 * case_subscore_generator(@s_id,329)) +
      (9.12 * case_subscore_generator(@s_id,326)) +
      (9.08 * case_subscore_generator(@s_id,325)) +
      (9.08 * case_subscore_generator(@s_id,324))
    ) / 100
  end

  def score_classroom_student_4Cs
    @score_classroom_student_4Cs = calc_weighted_score(
      score_classroom_student_high_4Cs,
      score_classroom_student_middle_4Cs,
      score_classroom_student_elementary_4Cs
    )
  end

  def score_classroom_4Cs
    @score_classroom_4Cs = calc_weighted_score(
      score_classroom_student_high_4Cs,
      score_classroom_student_middle_4Cs,
      score_classroom_student_elementary_4Cs,
      score_classroom_teacher_4Cs
    )
  end

  def score_classroom_teacher_digital_citizen
    @score_classroom_teacher_digital_citizen = (
      (8  * case_subscore_generator(@s_id,146)) +
      (8  * case_subscore_generator(@s_id,147)) +
      (8  * case_subscore_generator(@s_id,149)) +
      (8  * case_subscore_generator(@s_id,148)) +
      (8  * case_subscore_generator(@s_id,150)) +
      (15 * case_subscore_generator(@s_id,159)) +
      (15 * case_subscore_generator(@s_id,160)) +
      (15 * case_subscore_generator(@s_id,162)) +
      (15 * case_subscore_generator(@s_id,161))
    ) / 100
  end

  def score_classroom_student_high_digital_citizen
    @score_classroom_student_high_digital_citizen = (
      (22 * case_subscore_generator(@s_id,500)) +
      (22 * case_subscore_generator(@s_id,501)) +
      (22 * case_subscore_generator(@s_id,502)) +
      (22 * case_subscore_generator(@s_id,503)) 
  #    (12 * subscore_classroom_checkbox(476))
      )/88
  #  ) / 100
  end

  def score_classroom_student_middle_digital_citizen
    @score_classroom_student_middle_digital_citizen = (
      (22 * case_subscore_generator(@s_id,415)) +
      (22 * case_subscore_generator(@s_id,416)) +
      (22 * case_subscore_generator(@s_id,417)) +
      (22 * case_subscore_generator(@s_id,418))
    #  (12 * subscore_classroom_checkbox(391))
    #) / 100
      ) / 78
  end

  def score_classroom_student_elementary_digital_citizen
    @score_classroom_student_elementary_digital_citizen = (
      (25 * case_subscore_generator(@s_id,334)) +
      (25 * case_subscore_generator(@s_id,335)) +
      (25 * case_subscore_generator(@s_id,336)) +
      (25 * case_subscore_generator(@s_id,337))
    ) / 100
  end

  def score_classroom_student_digital_citizen
    @score_classroom_student_digital_citizen = calc_weighted_score(
      score_classroom_student_high_digital_citizen,
      score_classroom_student_middle_digital_citizen,
      score_classroom_student_elementary_digital_citizen
    )
  end

  def score_classroom_digital_citizen
    @score_classroom_digital_citizen = calc_weighted_score(
      score_classroom_student_high_digital_citizen,
      score_classroom_student_middle_digital_citizen,
      score_classroom_student_elementary_digital_citizen,
      score_classroom_teacher_digital_citizen
    )
  end

  def score_classroom
    @score_classroom = (
      (25 * score_classroom_teacher_4Cs) +
      (25 * score_classroom_student_4Cs) +
      (15 * score_classroom_teacher_digital_citizen) +
      (15 * score_classroom_student_digital_citizen) +
      (10 * score_classroom_teacher_assistive_tech) +
      (10 * score_classroom_teacher_assessment)
    ) / 100
  end

  #
  # Access
  #

  def score_access_teacher_school
    @score_access_teacher_school = (
      (25 *
        [
          case_subscore_generator(@s_id,44),
          case_subscore_generator(@s_id,45),
          case_subscore_generator(@s_id,46),
        ].max
      ) +
      (25 * (case_subscore_generator(@s_id,49) * (case_subscore_generator(@s_id,165) / 100))) +
      (20 * (case_subscore_generator(@s_id,47) * (case_subscore_generator(@s_id,167) / 100))) +
      (10 *  case_subscore_generator(@s_id,48)) +
      (5 *   case_subscore_generator(@s_id,56)) +
      (5 *   case_subscore_generator(@s_id,57)) +
      (2 *   case_subscore_generator(@s_id,58)) +
      (2 *   case_subscore_generator(@s_id,59)) +
      (2 *   case_subscore_generator(@s_id,60)) +
      (2 *   case_subscore_generator(@s_id,61)) +
      (2 *   case_subscore_generator(@s_id,62))
    ) / 100
  end

  def score_access_student_school
    @score_access_student_school = (
      (25 *
        (
           case_subscore_generator(@s_id,52) *
          (case_subscore_generator(@s_id,53) / 100) *
          (case_subscore_generator(@s_id,54) / 100) *
          (case_subscore_generator(@s_id,166) / 100)
        )
      ) +
      # yupthe remaining lines are a repeat from Access | Teacher @ School
      (25   * (case_subscore_generator(@s_id,49) * (case_subscore_generator(@s_id,165) / 100))) +
      (20   * (case_subscore_generator(@s_id,47) * (case_subscore_generator(@s_id,167) / 100))) +
      (5    *  case_subscore_generator(@s_id,48)) +
      (12.5 *  case_subscore_generator(@s_id,56)) +
      (12.5 *  case_subscore_generator(@s_id,57))
    ) / 100
  end

  def score_access_school
    # simple average suffices because all questions are from the teacher survey
    @score_access_school = (score_access_teacher_school + score_access_student_school) / 2
  end

  def score_access_teacher_home
    @score_access_teacher_home = (
      (35 *
        [
          case_subscore_generator(@s_id,64),
          case_subscore_generator(@s_id,65),
          case_subscore_generator(@s_id,66),
          case_subscore_generator(@s_id,50)
        ].max
      ) +
      (7  * case_subscore_generator(@s_id,67)) +
      (2  * case_subscore_generator(@s_id,68)) +
      (2  * case_subscore_generator(@s_id,69)) +
      (2  * case_subscore_generator(@s_id,70)) +
      (35 * case_subscore_generator(@s_id,71)) +
      (17 * case_subscore_generator(@s_id,72))
    ) / 100
  end

  def score_access_student_high_home
    @score_access_student_high_home = (
      (35 *
        [
          case_subscore_generator(@s_id,432),
          case_subscore_generator(@s_id,433),
          case_subscore_generator(@s_id,434),
          case_subscore_generator(@s_id,430)
        ].max
      ) +
      (7  * case_subscore_generator(@s_id,435)) +
      (2  * case_subscore_generator(@s_id,436)) +
      (2  * case_subscore_generator(@s_id,437)) +
      (2  * case_subscore_generator(@s_id,439)) +
      (35 * case_subscore_generator(@s_id,440)) +
      (17 * case_subscore_generator(@s_id,441))
    ) / 100
  end

  def score_access_student_middle_home
    @score_access_student_middle_home = (
      (35 *
        [
          case_subscore_generator(@s_id,347),
          case_subscore_generator(@s_id,348),
          case_subscore_generator(@s_id,349),
          case_subscore_generator(@s_id,345)
        ].max
      ) +
      (7  * case_subscore_generator(@s_id,350)) +
      (2  * case_subscore_generator(@s_id,353)) +
      (2  * case_subscore_generator(@s_id,352)) +
      (2  * case_subscore_generator(@s_id,354)) +
      (35 * case_subscore_generator(@s_id,355)) +
      (17 * case_subscore_generator(@s_id,356))
    ) / 100
  end

  def score_access_student_elementary_home
    @score_access_student_elementary_home = (
      (35 *
        [
          case_subscore_generator(@s_id,290),
          case_subscore_generator(@s_id,291),
          case_subscore_generator(@s_id,292),
          case_subscore_generator(@s_id,288)
        ].max
      ) +
      (7  * case_subscore_generator(@s_id,294)) +
      (2  * case_subscore_generator(@s_id,295)) +
      (2  * case_subscore_generator(@s_id,297)) +
      (2  * case_subscore_generator(@s_id,298)) +
      (35 * case_subscore_generator(@s_id,299)) +
      (17 * case_subscore_generator(@s_id,300))
    ) / 100
  end

  def score_access_student_home
    @score_access_student_home = calc_weighted_score(
      score_access_student_high_home,
      score_access_student_middle_home,
      score_access_student_elementary_home
    )
  end

  def score_access_home
    @score_access_home = calc_weighted_score(
      score_access_student_high_home,
      score_access_student_middle_home,
      score_access_student_elementary_home,
      score_access_teacher_home
    )
  end

  def score_access
    @score_access = (
      (30 * score_access_teacher_school) +
      (30 * score_access_student_school) +
      (20 * score_access_teacher_home) +
      (20 * score_access_student_home)
    ) / 100
  end

  #
  # Skills
  #

  def score_skills_teacher_foundational
    @score_skills_teacher_foundational = (
      (10 * case_subscore_generator(@s_id,75)) +
      (10 * case_subscore_generator(@s_id,74)) +
      (10 * case_subscore_generator(@s_id,76)) +
      (10 * case_subscore_generator(@s_id,92)) +
      (10 * case_subscore_generator(@s_id,93)) +
      (10 * case_subscore_generator(@s_id,94)) +
      (10 * case_subscore_generator(@s_id,85)) +
      (10 * case_subscore_generator(@s_id,84)) +
      (10 * case_subscore_generator(@s_id,106)) +
      (10 * case_subscore_generator(@s_id,107))
    ) / 100
  end

  def score_skills_student_high_foundational
    @score_skills_student_high_foundational = (
      (10 * case_subscore_generator(@s_id,444)) +
      (10 * case_subscore_generator(@s_id,443)) +
      (10 * case_subscore_generator(@s_id,445)) +
      (10 * case_subscore_generator(@s_id,459)) +
      (10 * case_subscore_generator(@s_id,460)) +
      (10 * case_subscore_generator(@s_id,461)) +
      (10 * case_subscore_generator(@s_id,454)) +
      (10 * case_subscore_generator(@s_id,453)) +
      (10 * case_subscore_generator(@s_id,471)) +
      (10 * case_subscore_generator(@s_id,472))
    ) / 100
  end

  def score_skills_student_middle_foundational
    @score_skills_student_middle_foundational = (
      (11.1 * case_subscore_generator(@s_id,358)) +
      (11.1 * case_subscore_generator(@s_id,359)) +
      (11.1 * case_subscore_generator(@s_id,360)) +
      (11.1 * case_subscore_generator(@s_id,374)) +
      (11.1 * case_subscore_generator(@s_id,381)) +
      (11.1 * case_subscore_generator(@s_id,382)) +
      (11.2 * case_subscore_generator(@s_id,369)) +
      (11.1 * case_subscore_generator(@s_id,368)) +
      (11.1 * case_subscore_generator(@s_id,387))
    ) / 100
  end

  def score_skills_student_elementary_foundational
    @score_skills_student_elementary_foundational = (
      (20 * case_subscore_generator(@s_id,302)) +
      (20 * case_subscore_generator(@s_id,305)) +
      (20 * case_subscore_generator(@s_id,311)) +
      (20 * case_subscore_generator(@s_id,308)) +
      (20 * case_subscore_generator(@s_id,307))
    ) / 100
  end

  def score_skills_student_foundational
    @score_skills_student_foundational = calc_weighted_score(
      score_skills_student_high_foundational,
      score_skills_student_middle_foundational,
      score_skills_student_elementary_foundational
    )
  end

  def score_skills_foundational
    @score_skills_foundational = calc_weighted_score(
      score_skills_student_high_foundational,
      score_skills_student_middle_foundational,
      score_skills_student_elementary_foundational,
      score_skills_teacher_foundational
    )
  end

  def score_skills_teacher_online
    @score_skills_teacher_online = (
      (10 * case_subscore_generator(@s_id,80)) +
      (10 * case_subscore_generator(@s_id,81)) +
      (10 * case_subscore_generator(@s_id,82)) +
      (10 * case_subscore_generator(@s_id,95)) +
      (10 * case_subscore_generator(@s_id,96)) +
      (10 * case_subscore_generator(@s_id,98)) +
      (10 * case_subscore_generator(@s_id,97)) +
      (10 * case_subscore_generator(@s_id,10)) +
      (10 *
        [
          case_subscore_generator(@s_id,101),
          case_subscore_generator(@s_id,102),
          case_subscore_generator(@s_id,103)
        ].max
      ) +
      (10 * case_subscore_generator(@s_id,104))
    ) / 100
  end

  def score_skills_student_high_online
    @score_skills_student_high_online = (
      (10 * case_subscore_generator(@s_id,449)) +
      (15 * case_subscore_generator(@s_id,450)) +
      (10 * case_subscore_generator(@s_id,451)) +
      (10 * case_subscore_generator(@s_id,462)) +
      (10 * case_subscore_generator(@s_id,463)) +
      (15 * case_subscore_generator(@s_id,464)) +
      (15 * case_subscore_generator(@s_id,466)) +
      (15 *
        [
          case_subscore_generator(@s_id,467),
          case_subscore_generator(@s_id,468),
          case_subscore_generator(@s_id,469)
        ].max
      )
    ) / 100
  end

  def score_skills_student_middle_online
    @score_skills_student_middle_online = (
      (20 * case_subscore_generator(@s_id,365)) +
      (20 * case_subscore_generator(@s_id,366)) +
      (20 * case_subscore_generator(@s_id,383)) +
      (20 * case_subscore_generator(@s_id,384)) +
      (20 * case_subscore_generator(@s_id,385))
    ) / 100
  end

  def score_skills_student_elementary_online
    @score_skills_student_elementary_online = (
      (33 * case_subscore_generator(@s_id,304)) +
      (33 * case_subscore_generator(@s_id,314)) +
      (34 * case_subscore_generator(@s_id,315))
    ) / 100
  end

  def score_skills_student_online
    @score_skills_student_online = calc_weighted_score(
      score_skills_student_high_online,
      score_skills_student_middle_online,
      score_skills_student_elementary_online
    )
  end

  def score_skills_online
    @score_skills_online = calc_weighted_score(
      score_skills_student_high_online,
      score_skills_student_middle_online,
      score_skills_student_elementary_online,
      score_skills_teacher_online
    )
  end

  def score_skills_teacher_multimedia
    @score_skills_teacher_multimedia = (
      (20 * case_subscore_generator(@s_id,77)) +
      (20 * case_subscore_generator(@s_id,78)) +
      (20 * case_subscore_generator(@s_id,79)) +
      (20 * case_subscore_generator(@s_id,89)) +
      (20 * case_subscore_generator(@s_id,90))
    ) / 100
  end

  def score_skills_student_high_multimedia
    @score_skills_student_high_multimedia = (
      (20 * case_subscore_generator(@s_id,446)) +
      (20 * case_subscore_generator(@s_id,447)) +
      (20 * case_subscore_generator(@s_id,448)) +
      (20 * case_subscore_generator(@s_id,456)) +
      (20 * case_subscore_generator(@s_id,457))
    ) / 100
  end

  def score_skills_student_middle_multimedia
    @score_skills_student_middle_multimedia = (
      (20 * case_subscore_generator(@s_id,361)) +
      (20 * case_subscore_generator(@s_id,363)) +
      (20 * case_subscore_generator(@s_id,364)) +
      (20 * case_subscore_generator(@s_id,371)) +
      (20 * case_subscore_generator(@s_id,372))
    ) / 100
  end

  def score_skills_student_elementary_multimedia
    @score_skills_student_elementary_multimedia = (
      (33 * case_subscore_generator(@s_id,303)) +
      (34 * case_subscore_generator(@s_id,310)) +
      (33 * case_subscore_generator(@s_id,313))
    ) / 100
  end

  def score_skills_student_multimedia
    @score_skills_student_multimedia = calc_weighted_score(
      score_skills_student_high_multimedia,
      score_skills_student_middle_multimedia,
      score_skills_student_elementary_multimedia
    )
  end

  def score_skills_multimedia
    @score_skills_multimedia = calc_weighted_score(
      score_skills_student_high_multimedia,
      score_skills_student_middle_multimedia,
      score_skills_student_elementary_multimedia,
      score_skills_teacher_multimedia
    )
  end

  def score_skills
    @score_skills = (
      (17.5 * score_skills_teacher_foundational) +
      (17.5 * score_skills_student_foundational) +
      (17.5 * score_skills_teacher_online) +
      (17.5 * score_skills_student_online) +
      (15 * score_skills_teacher_multimedia) +
      (15 * score_skills_student_multimedia)
    ) / 100
  end

  #
  # Environment
  #

  def score_environment_teacher_professional_learning
    @score_environment_teacher_professional_learning = (
      (25 * case_subscore_generator(@s_id,193)) +
      (10 * case_subscore_generator(@s_id,194)) +
      (15 * case_subscore_generator(@s_id,195)) +
      (25 * case_subscore_generator(@s_id,189)) +
      (10 * case_subscore_generator(@s_id,190)) +
      (15 * case_subscore_generator(@s_id,191))
    ) / 100
  end

  def score_environment_teacher_three_ps
    @score_environment_teacher_three_ps = (
      (20 * case_subscore_generator(@s_id,184)) +
      (20 * case_subscore_generator(@s_id,185)) +
      (20 * case_subscore_generator(@s_id,186)) +
      (10 * case_subscore_generator(@s_id,187)) +
      #(10 * subscore_environment_teacher_three_ps) +
      (20 * case_subscore_generator(@s_id,163))
    ) / 90
    #) / 100
  end

  def score_environment_teacher_support
    @score_environment_teacher_support = (
      (20 * case_subscore_generator(@s_id,168)) +
      (10 * case_subscore_generator(@s_id,169)) +
      (10 * case_subscore_generator(@s_id,170)) +
      (10 * case_subscore_generator(@s_id,171)) +
      (20 * case_subscore_generator(@s_id,173)) +
      (10 * case_subscore_generator(@s_id,174)) +
      (10 * case_subscore_generator(@s_id,175)) +
      (10 * case_subscore_generator(@s_id,176))
    ) / 100
  end

  def score_environment_high_beliefs
    @score_environment_high_beliefs = (
      (20 * case_subscore_generator(@s_id,507)) +
      (20 * case_subscore_generator(@s_id,509)) +
      (10 * case_subscore_generator(@s_id,510)) +
      (10 * case_subscore_generator(@s_id,511)) +
      (10 * case_subscore_generator(@s_id,508)) 
   #   (30 * subscore_environment_checkbox(504))
      )/70
   # ) / 100
  end

  def score_environment_middle_beliefs
    @score_environment_middle_beliefs = (
      (20 * case_subscore_generator(@s_id,422)) +
      (20 * case_subscore_generator(@s_id,424)) +
      (10 * case_subscore_generator(@s_id,425)) +
      (10 * case_subscore_generator(@s_id,426)) +
      (10 * case_subscore_generator(@s_id,423)) 
 #     (30 * subscore_environment_checkbox(419))
      ) / 70
 #   ) / 100
  end

  def score_environment_elementary_beliefs
    @score_environment_elementary_beliefs = (
      (34 * case_subscore_generator(@s_id,339)) +
      (33 * case_subscore_generator(@s_id,341)) +
      (33 * case_subscore_generator(@s_id,340))
    ) / 100
  end

  def score_environment_teacher_beliefs
    @score_environment_teacher_beliefs = (
      (20 * case_subscore_generator(@s_id,178)) +
      (20 * case_subscore_generator(@s_id,180)) +
      (10 * case_subscore_generator(@s_id,181)) +
      (10 * case_subscore_generator(@s_id,182)) +
      (10 * case_subscore_generator(@s_id,179)) +
      (15 * case_subscore_generator(@s_id,87)) +
      (15 * case_subscore_generator(@s_id,86))
    ) / 100
  end

  def score_environment_beliefs
    @score_environment_beliefs = calc_weighted_score(
      score_environment_high_beliefs,
      score_environment_middle_beliefs,
      score_environment_elementary_beliefs,
      score_environment_teacher_beliefs
    )
  end

  def score_environment
    @score_environment = (
      (25 * score_environment_teacher_professional_learning) +
      (25 * score_environment_teacher_three_ps) +
      (25 * score_environment_teacher_support) +
      (25 * score_environment_teacher_beliefs)
    ) / 100
  end



#read in the weights
weights = Hash.new
weights_file = CSV.read('/Users/Esthena/Dropbox/EBDesktop/coefficients/question_weight_input.csv')
weights_file.shift
weights_file.each do |row|
  q_id = row[0]
  arr = row.slice(1,7)
  weights[q_id] = arr
end

def options_count arr
  count = 0
  for a in arr
    if !a.eql?(nil)
      count +=1
    end
  end
  return count
end
  
@response_hash = Hash.new 
@teacher_response_counts = Hash.new
@hs_student_response_counts = Hash.new
@ms_student_response_counts = Hash.new
@elem_student_response_counts = Hash.new
response_file = CSV.read('/Users/Esthena/Desktop/stmarys.csv')
current_school_id = ""
response_file.each do |row|
  if row[0].to_i() > 600
    current_school_id = row[0]
    @response_hash[current_school_id] = Hash.new
  else
    q_id = row[0]
    counts = row.slice(1,7)
    total = row[8].to_f()
    if q_id.to_i() < 203
      @teacher_response_counts[current_school_id] = total
    else
        if (q_id.to_i() > 287 and q_id.to_i() < 344)
          @elem_student_response_counts[current_school_id] = total
        else
          if q_id.to_i() < 429
            @ms_student_response_counts[current_school_id] = total
          else
            @hs_student_response_counts[current_school_id] = total
          end
        end
    end
    q_wts = weights[q_id]
    if q_wts == nil
      next
    end
    q_score = 0
    i = 0
    while i < options_count(q_wts)
      q_score += counts[i].to_f()*q_wts[i].to_f()/100/total
      i+=1
    end
    @response_hash[current_school_id][q_id.to_s()] = q_score.to_s()
  end


end
#puts @teacher_response_counts
#puts @hs_student_response_counts
#puts @ms_student_response_counts
#puts @elem_student_response_counts

success_indicators = ["score_classroom_teacher_assistive_tech", "score_classroom_teacher_assessment", "score_classroom_teacher_4Cs", "score_classroom_student_high_4Cs", "score_classroom_student_middle_4Cs", "score_classroom_student_elementary_4Cs", "score_classroom_student_4Cs", "score_classroom_4Cs", "score_classroom_teacher_digital_citizen", "score_classroom_student_high_digital_citizen", "score_classroom_student_middle_digital_citizen", "score_classroom_student_elementary_digital_citizen", "score_classroom_student_digital_citizen", "score_classroom_digital_citizen", "score_classroom", "score_access_teacher_school", "score_access_student_school", "score_access_school", "score_access_teacher_home", "score_access_student_high_home", "score_access_student_middle_home", "score_access_student_elementary_home", "score_access_student_home", "score_access_home", "score_access", "score_skills_teacher_foundational", "score_skills_student_high_foundational", "score_skills_student_middle_foundational", "score_skills_student_elementary_foundational", "score_skills_student_foundational", "score_skills_foundational", "score_skills_teacher_online", "score_skills_student_high_online", "score_skills_student_middle_online", "score_skills_student_elementary_online", "score_skills_student_online", "score_skills_online", "score_skills_teacher_multimedia", "score_skills_student_high_multimedia", "score_skills_student_middle_multimedia", "score_skills_student_elementary_multimedia", "score_skills_student_multimedia", "score_skills_multimedia", "score_skills", "score_environment_teacher_professional_learning", "score_environment_teacher_three_ps", "score_environment_teacher_support", "score_environment_high_beliefs", "score_environment_middle_beliefs", "score_environment_elementary_beliefs", "score_environment_teacher_beliefs", "score_environment_beliefs", "score_environment"]
print success_indicators
puts ""
methods = [method(:score_classroom_teacher_assistive_tech), method(:score_classroom_teacher_assessment), method(:score_classroom_teacher_4Cs), method(:score_classroom_student_high_4Cs), method(:score_classroom_student_middle_4Cs), method(:score_classroom_student_elementary_4Cs), method(:score_classroom_student_4Cs), method(:score_classroom_4Cs), method(:score_classroom_teacher_digital_citizen), method(:score_classroom_student_high_digital_citizen), method(:score_classroom_student_middle_digital_citizen), method(:score_classroom_student_elementary_digital_citizen), method(:score_classroom_student_digital_citizen), method(:score_classroom_digital_citizen), method(:score_classroom), method(:score_access_teacher_school), method(:score_access_student_school), method(:score_access_school), method(:score_access_teacher_home), method(:score_access_student_high_home), method(:score_access_student_middle_home), method(:score_access_student_elementary_home), method(:score_access_student_home), method(:score_access_home), method(:score_access), method(:score_skills_teacher_foundational), method(:score_skills_student_high_foundational), method(:score_skills_student_middle_foundational), method(:score_skills_student_elementary_foundational), method(:score_skills_student_foundational), method(:score_skills_foundational), method(:score_skills_teacher_online), method(:score_skills_student_high_online), method(:score_skills_student_middle_online), method(:score_skills_student_elementary_online), method(:score_skills_student_online), method(:score_skills_online), method(:score_skills_teacher_multimedia), method(:score_skills_student_high_multimedia), method(:score_skills_student_middle_multimedia), method(:score_skills_student_elementary_multimedia), method(:score_skills_student_multimedia), method(:score_skills_multimedia), method(:score_skills), method(:score_environment_teacher_professional_learning), method(:score_environment_teacher_three_ps), method(:score_environment_teacher_support), method(:score_environment_high_beliefs), method(:score_environment_middle_beliefs), method(:score_environment_elementary_beliefs), method(:score_environment_teacher_beliefs), method(:score_environment_beliefs), method(:score_environment)]
for key in @response_hash.each_key
 k=0
  @s_id = key  
  puts @s_id
  while k< success_indicators.length()
    b =methods[k].call
    print (b*500+800).round.to_s() + ","
    k+=1
  end
  puts ""
end


