Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C5C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 19:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F0FC40BA5;
	Fri, 11 Apr 2025 21:43:24 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 496CF40B91
 for <dev@dpdk.org>; Fri, 11 Apr 2025 21:43:22 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-306b602d2ffso2610653a91.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744400601; x=1745005401; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7seVPfVQo3UdSJG9emqgkLv7JAaN4Pl8oQdnEFZBhG8=;
 b=VipSqwrzALh6iD1WhCC8z91LpUVF70FYE8Rh5NA8k4gC5nrMRyVBAqrzOeaSF1ok6S
 LwYciLCk0C9y9bX3aLzNRF93fMD6qyuS4ADDYsZ5YgHskFJ8gpgwo103gq3sXYpbZkXD
 n3PKt9KslciwaVrsgAA36lEGCbMbtz/6NyGHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744400601; x=1745005401;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7seVPfVQo3UdSJG9emqgkLv7JAaN4Pl8oQdnEFZBhG8=;
 b=PHImU/9sbhVjWdfLIrHPA2nP6ttmeVCWqA7gx4gLUciA9+c/ia982SymXbAZr7Fg6m
 yKSZcP4fs48yfb/I2/MLdZ3CRZnXCuZzKese+6wEGeTrenRzwg/cUDpRiPOwRH/EqNcP
 6nCAugtkvDzHj7dhVpOzE0y8xrAjoS8J10kU1ReevnqMSuym+fusUnEQwsM7PWW2RxlV
 HPv01Gqy89AEZkFQYGaDBniKL3kqm+lRMB8QsLg1zMjV3sesCdTuY8EdWJuea7nVhL6W
 VR+6y2WTB3e/F8M3dSBlMsVwPVYQ2ZOg+LySwK89Jjev42FMT4z8ZkaOHaJOZ7m5LYpH
 QY3g==
X-Gm-Message-State: AOJu0Yz6cWzEJZSK44XsD+Rrx3v0oMfUCzYBDMSZ6RdL83HfMOlHqLEY
 gaRfR8GiugxAi0r40BpyEjcCAoHHsWu74YmHiOY3LBcnMPkXy+vi67CLhVJ/arzlhzrcdWnXUUv
 axC7lNxuPnXAifyHoj/Vp/YhMJooo657c+Q7PwnahAkTCymCItKlVYQ==
X-Gm-Gg: ASbGncsE1yuMg1czw3y7jnwySC4bgVI5ebhYO3pTE7ydm4bw/ULSFAG6yZBbkagUS7x
 uKAdWJaK9qU+ssC40hDh2GX4WMiXuY8ajRfbxByJD5vN2k6nSTNiAxGMP2mXK/4bntOa0D0DXDp
 JNVWS2K+CoIxaYNRMaqhOXFLzwkOxkWjUzGL+b
X-Google-Smtp-Source: AGHT+IEdWIwMZuvudvXjoL0qk5EfBGwoSNbSAbJLWPOVjtLa0h3u6OrMBqYnJsa+uQY5HoUAlkDYxRY6HZ1+dEuJpsM=
X-Received: by 2002:a17:90b:264b:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-30823624847mr5973921a91.5.1744400600641; Fri, 11 Apr 2025
 12:43:20 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 11 Apr 2025 15:39:11 -0400
X-Gm-Features: ATxdqUF0KSAQ60j0qeMzCNZn9rydGciuzUcz2bL4kgopn3NdcIifLpbLkQlCALM
Message-ID: <CAJvnSUC3sqE5jTY52Lu-WYmjnjSe_AQMjWh2k=kyCtxqYY+Raw@mail.gmail.com>
Subject: DTS Meeting Minutes - April 10, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000025cb64063285ea7a"
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

--00000000000025cb64063285ea7a
Content-Type: text/plain; charset="UTF-8"

#####################################################################
April 10, 2025
Attendees
* Patrick Robb
* Luca Vizzarro

#####################################################################
Minutes

=====================================================================
General Discussion
* DTS 25.07 roadmap emailed out:
https://inbox.dpdk.org/dev/CAJvnSUCB4wicXzKsgewF70dgaoE=AoFpCbzzPr0nABwYLvgU1g@mail.gmail.com/T/#u
   * We will track the work during the release using the roadmap status
google doc:
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=t.0
* UNH Lab: Dean updated our jenkins script which runs the DTS runner docker
image (with the main.py entrypoint) so that we collect the DTS exit code
and can get automatically alerted when there is a DTS framework/internal
error in our CI. We made this change since we had some test runs silently
failing last week due to a tarball naming conflict.

=====================================================================
Patch discussions
* Paul merged the patch adding the new async sniffer:
https://git.dpdk.org/next/dpdk-next-dts/commit/?id=c933d60a7f8696695eb08ae655f2d809aedc29d5
* Rte_flow: We will need to get clarity from the flow maintainer on what
patterns/rules represent the core functionality and should be a part of the
flow testsuite.
   * Dean has drafted an email to this effect, which should go out today.
* Performance tests TG support (TREX):
   * Nick is ironing out some bugfixes, but we should have an RFC by the
end of his shift on Friday
* Reviews needed! Patrick and Dean should do this Thursday/Friday.
   * Packet capture testsuites:
https://patchwork.dpdk.org/project/dpdk/list/?series=34950
   * RSS testsuites:
https://patchwork.dpdk.org/project/dpdk/list/?series=34713
   * Shell refactoring patchseries:
https://patchwork.dpdk.org/project/dpdk/list/?series=34865

=====================================================================
Bugzilla discussions
* Reminder: As you begin work on roadmap items, ensure that there is a
bugzilla ticket created which tracks that work

=====================================================================
Any other business
* Next meeting is Apr 24, 2025

--00000000000025cb64063285ea7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>April 10, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vizz=
arro<br><br>###############################################################=
######<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>General Discussion<br>* DTS 25.07 roadmap emailed out: <a href=
=3D"https://inbox.dpdk.org/dev/CAJvnSUCB4wicXzKsgewF70dgaoE=3DAoFpCbzzPr0nA=
BwYLvgU1g@mail.gmail.com/T/#u">https://inbox.dpdk.org/dev/CAJvnSUCB4wicXzKs=
gewF70dgaoE=3DAoFpCbzzPr0nABwYLvgU1g@mail.gmail.com/T/#u</a><br>=C2=A0 =C2=
=A0* We will track the work during the release using the roadmap status goo=
gle doc: <a href=3D"https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7f=
EJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0">https://docs.google.com/document/d=
/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0</a><br>* UNH L=
ab: Dean updated our jenkins script which runs the DTS runner docker image =
(with the main.py entrypoint) so that we collect the DTS exit code and can =
get automatically alerted when there is a DTS framework/internal error in o=
ur CI. We made this change since we had some test runs silently failing las=
t week due to a tarball naming conflict.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Paul merged the pa=
tch adding the new async sniffer: <a href=3D"https://git.dpdk.org/next/dpdk=
-next-dts/commit/?id=3Dc933d60a7f8696695eb08ae655f2d809aedc29d5">https://gi=
t.dpdk.org/next/dpdk-next-dts/commit/?id=3Dc933d60a7f8696695eb08ae655f2d809=
aedc29d5</a><br>* Rte_flow: We will need to get clarity from the flow maint=
ainer on what patterns/rules represent the core functionality and should be=
 a part of the flow testsuite. <br>=C2=A0 =C2=A0* Dean has drafted an email=
 to this effect, which should go out today.<br>* Performance tests TG suppo=
rt (TREX): <br>=C2=A0 =C2=A0* Nick is ironing out some bugfixes, but we sho=
uld have an RFC by the end of his shift on Friday<br>* Reviews needed! Patr=
ick and Dean should do this Thursday/Friday.<br>=C2=A0 =C2=A0* Packet captu=
re testsuites: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?ser=
ies=3D34950">https://patchwork.dpdk.org/project/dpdk/list/?series=3D34950</=
a><br>=C2=A0 =C2=A0* RSS testsuites: <a href=3D"https://patchwork.dpdk.org/=
project/dpdk/list/?series=3D34713">https://patchwork.dpdk.org/project/dpdk/=
list/?series=3D34713</a><br>=C2=A0 =C2=A0* Shell refactoring patchseries: <=
a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D34865">htt=
ps://patchwork.dpdk.org/project/dpdk/list/?series=3D34865</a><br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions=
<br>* Reminder: As you begin work on roadmap items, ensure that there is a =
bugzilla ticket created which tracks that work<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next meetin=
g is Apr 24, 2025</div>

--00000000000025cb64063285ea7a--
