Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE89FD3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B98C427D9;
	Wed, 14 Jan 2026 23:56:20 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 2879D427D0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:56:18 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2817545e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768431378;
 x=1769036178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hz7qEy1i817Tdg+7LCR02/1TsN5/g0+f0i0HPsD+R0=;
 b=nGl3aqCQBAVGQelN6iGZfNvixTuK0TQRw+Elb3L8xp6qyCHEgKsrS/JLhwdD6nhUZq
 N7J9kY3JER+543C39fnwCoV3uyHqdN/mEloGRkB/eNpfEJbol+wqd4x9nNdlGSa3TPj6
 e1aiQpwRB1106Zqvw8bc44BX6jejH+SrVKHcByzfkKIGEz2xhPTH21z15K/Q/7FRDNoB
 ceF7BAG7U99ALo01Jl0f71J0qhkFje6p35WaAdjL+HRH7umdObFxByLrZgRdWROSlz/z
 RkIQHCbNgEhk4HDjQo6gB6REn5NkVk0LFNm+/189wEClb8cbMCz/btuou+9/05FV9k91
 9Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768431378; x=1769036178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7hz7qEy1i817Tdg+7LCR02/1TsN5/g0+f0i0HPsD+R0=;
 b=AGII9AeA3vAm167e52Csg1QfjD0JCzKywMSjko67oRQkStF4TVzBPwWireldowqv4T
 qWmgHxQ6zkV0j0I5sjf1SWwGJpx8jCaL9d7Tp69DHzxQz9sG8owc7cN7+JBhAk9JE9Gy
 uWSU0c4FyOqjCRx4Jud/1LZEm4MllaL04r66LSWTNlZofyO4qKdSitOKLBOhJjo5lqn5
 OM8ien7L6WT4/dWllULTrn5MukilLk4OlMMiIU9QCT2r6dwvhOAKk91QFnRbYJkuKnwr
 MsjweDlRFzv3mjL7hYrWI/bH/r+dzQb+OKBP7EublHRhu6FZwmUY4oYfjfOelx3ZKvsw
 vtlg==
X-Gm-Message-State: AOJu0Yz9XJq50YogyG9z0xMcnni539uiy2ScL8U26IXr73O09utTOwfl
 eFXlU/uQZZMzUWHnkoE35DNPTxkGc34Vf/G0IWOkRP1YxJrl9Dlss8Ifj5MwuEIKGYjRADdzl/H
 W7DgYgdw=
X-Gm-Gg: AY/fxX4WMAJi46kjjXLqjQwgxAVVzQV3/GBlJq9droqd3g2uc50Tbl/TsHCqFZEEYMU
 Bru4m/6QVZdf3rngJq+qWnjhgtwtFFMjqhx1WGqzxZsF8YEs1B1Y9iT3XhZ7KOrAf56cvwIBtsE
 llrnFYJJdFANpp+oqrXdpaO1mwJDF197m5S+U9UUxB7wQRlXMdARO9/WkCvNKAFuKFp8XVE4daO
 0q9R37qrC5GrIdcOKEd7Sckg/pDme+shBk4kUCPkCt02rpiMRig7/6TzSINR/wRU7WliPE89xy+
 DOpLUK8sEwi/yf1bWblSYEk2LZlV2deSGxgy4koH4Redn/TQzoUQZZRWHNIwyrEvb4UFHmWJGnb
 xM4UMPAzaadS7HDaiFfSQhPX5KioK+fbmWdYS9TE0eUtwio4HkyFu/Ef8uz69ox1HT8ExZosInw
 G08c+KR6cVkG0+DOTXsjA5ij16IzoQA3/EOITSaaaHyHv3ENKbIw==
X-Received: by 2002:a05:600c:3109:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-47ee4822522mr41597525e9.24.1768431377719; 
 Wed, 14 Jan 2026 14:56:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428af0c7sm12999125e9.4.2026.01.14.14.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:56:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 11/11] doc: improve vulnerability process documentation
Date: Wed, 14 Jan 2026 14:54:15 -0800
Message-ID: <20260114225555.127448-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114225555.127448-1-stephen@networkplumber.org>
References: <20260114225555.127448-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Improve the vulnerability management documentation
- Converting passive voice to active voice
- Using clearer section headings
- Simplifying verbose explanations
- Making reporting instructions more direct
- Fixing broken RST link syntax for mailing lists

No technical content changes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/contributing/vulnerability.rst | 140 ++++++++++------------
 1 file changed, 65 insertions(+), 75 deletions(-)

diff --git a/doc/guides/contributing/vulnerability.rst b/doc/guides/contributing/vulnerability.rst
index fc60e02e37..1d616d203a 100644
--- a/doc/guides/contributing/vulnerability.rst
+++ b/doc/guides/contributing/vulnerability.rst
@@ -7,10 +7,9 @@ DPDK Vulnerability Management Process
 Scope
 -----
 
-Only the main repositories (dpdk and dpdk-stable) of the core project
-are in the scope of this security process (including experimental APIs).
-If a stable branch is declared unmaintained (end of life),
-no fix will be applied.
+This security process covers only the main repositories (dpdk and dpdk-stable)
+of the core project (including experimental APIs).
+The team will not apply fixes to stable branches declared unmaintained (end of life).
 
 All vulnerabilities are bugs, but not every bug is a vulnerability.
 Vulnerabilities compromise one or more of:
@@ -19,79 +18,71 @@ Vulnerabilities compromise one or more of:
 * Integrity (trustworthiness and correctness).
 * Availability (uptime and service).
 
-If in doubt, please consider the vulnerability as security sensitive.
+If in doubt, consider the vulnerability as security sensitive.
 At worst, the response will be to report the bug through the usual channels.
 
 
-Finding
--------
+Finding Security Issues
+-----------------------
 
 There is no pro-active security engineering effort at the moment.
 
-Please report any security issue you find in DPDK as described below.
+Report any security issue you find in DPDK as described below.
 
 
-Report
-------
+Reporting Security Issues
+-------------------------
 
-Do not use Bugzilla (unsecured).
-Instead, send GPG-encrypted emails
-to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
-Anyone can post to this list.
-In order to reduce the disclosure of a vulnerability in the early stages,
-membership of this list is intentionally limited to a `small number of people
-<https://mails.dpdk.org/roster/security>`_.
+Do not use Bugzilla to report security vulnerabilities, as it is not secured for such communication.
+Instead, send a GPG-encrypted email to `security@dpdk.org <https://core.dpdk.org/security#contact>`_.
+This address is open to all, but access to its inbox is intentionally limited to a small group
+to minimize the risk of early disclosure.
 
-It is additionally encouraged to GPG-sign one-on-one conversations
-as part of the security process.
+GPG-sign any one-on-one correspondence related to the vulnerability
+report as part of maintaining a secure communication process.
 
-As it is with any bug, the more information provided,
-the easier it will be to diagnose and fix.
-If you already have a fix, please include it with your report,
-as that can speed up the process considerably.
+As with any bug report, detailed information greatly aids in diagnosing and resolving the issue.
+If you have already developed a fix, include it in your submission to help accelerate resolution.
 
-In the report, please note how you would like to be credited
-for discovering the issue
-and the details of any embargo you would like to impose.
+In your report, specify how you would like to be credited for the discovery and mention any embargo
+period you wish to impose.
 
-If the vulnerability is not public yet,
-no patch or information should be disclosed publicly.
-If a fix is already published,
-the reporting process must be followed anyway, as described below.
+If the vulnerability has not yet been made public, do not disclose patches or related information
+publicly. Even if a fix has already been published, you must still follow the proper reporting process outlined here.
 
 
 Confirmation
 ------------
 
-Upon reception of the report, a security team member should reply
-to the reporter acknowledging that the report has been received.
+Upon receiving the report, a security team member should reply
+to the reporter acknowledging receipt.
 
 The DPDK security team reviews the security vulnerability reported.
-Area experts not members of the security team may be involved in the process.
-In case the reported issue is not qualified as a security vulnerability,
+Area experts who are not members of the security team may be involved in the process.
+If the reported issue does not qualify as a security vulnerability,
 the security team will request the submitter to report it
 using the usual channel (Bugzilla).
-If qualified, the security team will assess which DPDK version are affected.
-A bugzilla ID (allocated in a `reserved pool
+If qualified, the security team assesses which DPDK versions are affected.
+A bugzilla ID (allocated from a `reserved pool
 <https://bugs.dpdk.org/buglist.cgi?f1=bug_group&o1=equals&v1=security>`_)
 is assigned to the vulnerability, and kept empty until public disclosure.
 
-The security team calculates the severity score with
+The security team calculates the severity score with the
 `CVSS calculator <https://www.first.org/cvss/calculator/3.0>`_
 based on inputs from the reporter and its own assessment of the vulnerability,
 and agrees on the score with the reporter.
 
 An embargo may be put in place depending on the severity of the vulnerability.
-If an embargo is decided, its duration should be suggested by the security team
-and negotiated with the reporter.
+If an embargo is decided, the security team should suggest the duration
+and negotiate with the reporter.
 Embargo duration between vulnerability confirmation and public disclosure
 should be between **one and ten weeks**.
 If an embargo is not required, the vulnerability may be fixed
 using the standard patch process, once a CVE number has been assigned.
 
-The confirmation mail should be sent within **3 business days**.
+Send the confirmation mail within **3 business days**.
 
-Following information must be included in the mail:
+Include the following information in the mail:
 
 * Confirmation
 * CVSS severity and score
@@ -110,7 +101,7 @@ from the reporter before finalizing the document.
 When the document is final, the security team needs to
 request a CVE identifier from a CNA.
 
-The CVE request should be sent
+Send the CVE request
 to `secalert@redhat.com <mailto:secalert@redhat.com>`_
 using GPG encrypted email
 (see `contact details <https://access.redhat.com/security/team/contact>`_).
@@ -161,19 +152,18 @@ CVE Request Template without Embargo
 Fix Development and Review
 --------------------------
 
-If the fix is already published, this step is skipped,
-and the pre-release disclosure is replaced with the private disclosure,
-as described below. It must not be considered as the standard process.
+If the fix is already published, skip this step,
+and replace the pre-release disclosure with the private disclosure,
+as described below. This should not be considered the standard process.
 
-This step may be started in parallel with CVE creation.
-The patches fixing the vulnerability are developed and reviewed
-by the security team and
-by elected area experts that agree to maintain confidentiality.
+This step may start in parallel with CVE creation.
+The security team and elected area experts who agree to maintain confidentiality
+develop and review patches fixing the vulnerability.
 
-The CVE id and the bug id must be referenced in the patch if there is no
-embargo, or if there is an embargo, but it will be lifted when the release
-including the patch is published. If the embargo is going to be lifted after the
-release, then the CVE and bug ids must be omitted from the commit message.
+Reference the CVE id and the bug id in the patch if there is no
+embargo, or if the embargo will be lifted when the release
+including the patch is published. If the embargo will be lifted after the
+release, omit the CVE and bug ids from the commit message.
 
 Backports to the identified affected versions are done once the fix is ready.
 
@@ -181,32 +171,32 @@ Backports to the identified affected versions are done once the fix is ready.
 Pre-Release Disclosure
 ----------------------
 
-When the fix is ready, the security advisory and patches are sent
+When the fix is ready, send the security advisory and patches
 to downstream stakeholders
 (`security-prerelease@dpdk.org <mailto:security-prerelease@dpdk.org>`_),
 specifying the date and time of the end of the embargo.
-The communicated public disclosure date should be **less than one week**
+The communicated public disclosure date should be **less than one week**.
 
 Downstream stakeholders are expected not to deploy or disclose patches
-until the embargo is passed, otherwise they will be removed from the list.
+until the embargo passes; otherwise they will be removed from the list.
 
 Downstream stakeholders (in `security-prerelease list
-<https://mails.dpdk.org/roster/security-prerelease>`_), are:
+<https://mails.dpdk.org/roster/security-prerelease>`_) are:
 
 * Operating system vendors known to package DPDK
 * Major DPDK users, considered trustworthy by the technical board, who
   have made the request to `techboard@dpdk.org <mailto:techboard@dpdk.org>`_
 
-The `OSS security private mailing list mailto:distros@vs.openwall.org>` will
+The `OSS security private mailing list <mailto:distros@vs.openwall.org>`_ will
 also be contacted one week before the end of the embargo, as indicated by `the
-OSS-security process <https://oss-security.openwall.org/wiki/mailing-lists/distros>`
+OSS-security process <https://oss-security.openwall.org/wiki/mailing-lists/distros>`_
 and using the PGP key listed on the same page, describing the details of the
 vulnerability and sharing the patch[es]. Distributions and major vendors follow
 this private mailing list, and it functions as a single point of contact for
 embargoed advance notices for open source projects.
 
-The security advisory will be based on below template,
-and will be sent signed with a security team's member GPG key.
+The security advisory will be based on the template below,
+and will be sent signed with a security team member's GPG key.
 
 
 Pre-Release Mail Template
@@ -234,7 +224,7 @@ Pre-Release Mail Template
   Please do not make the issue public (or release public patches)
   before this coordinated embargo date.
 
-If the issue is leaked during the embargo, the same procedure is followed
+If the issue is leaked during the embargo, follow the same procedure
 with only a few days delay between the pre-release and the public disclosure.
 
 
@@ -242,9 +232,9 @@ Private Disclosure
 ------------------
 
 If a vulnerability is unintentionally already fixed in the public repository,
-a security advisory is sent to downstream stakeholders
+send a security advisory to downstream stakeholders
 (`security-prerelease@dpdk.org <mailto:security-prerelease@dpdk.org>`_),
-giving few days to prepare for updating before the public disclosure.
+giving a few days to prepare for updating before the public disclosure.
 
 
 Private Disclosure Mail Template
@@ -275,23 +265,23 @@ Private Disclosure Mail Template
 Public Disclosure
 -----------------
 
-On embargo expiration, following tasks will be done simultaneously:
+When the embargo expires, carry out the following actions simultaneously:
 
-* The assigned bug is filled by a member of the security team,
-  with all relevant information, and it is made public.
-* The patches are pushed to the appropriate branches.
-* For long and short term stable branches fixed,
-  new versions should be released.
+* A security team member files the assigned bug with all relevant details and makes it publicly accessible.
 
-Releases on Monday to Wednesday are preferred, so that system administrators
-do not have to deal with security updates over the weekend.
+* Push the associated patches to the appropriate branches.
 
-The security advisory is posted
+* Release updated versions for all affected stable branches, both short-term and long-term.
+
+To ease adoption by system administrators, preferably schedule security releases
+between Monday and Wednesday, avoiding weekends.
+
+Post the security advisory
 to `announce@dpdk.org <mailto:announce@dpdk.org>`_ and to `the public OSS-security
-mailing list <mailto:oss-security@lists.openwall.com>` as soon as the patches
+mailing list <mailto:oss-security@lists.openwall.com>`_ as soon as the patches
 are pushed to the appropriate branches.
 
-Patches are then sent to `dev@dpdk.org <mailto:dev@dpdk.org>`_
+Send patches to `dev@dpdk.org <mailto:dev@dpdk.org>`_
 and `stable@dpdk.org <mailto:stable@dpdk.org>`_ accordingly.
 
 
-- 
2.51.0

