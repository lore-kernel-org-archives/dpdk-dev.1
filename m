Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1132FC369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 14:23:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FB4B40608;
	Fri, 25 Apr 2025 16:23:47 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 14A614025E
 for <dev@dpdk.org>; Fri, 25 Apr 2025 16:23:46 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so3167331a91.3
 for <dev@dpdk.org>; Fri, 25 Apr 2025 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745591025; x=1746195825; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7/ujgAFLjRhkWvT0jXJVoYdEEW7ZuWTpv/Ha3rgiOx0=;
 b=YISuOOLLdti0ARJSmDcNHJbcjLveucdI8or+vzv9O3nsh38q3WR15ljiKdFUefmyRD
 BMJjFJl2VMZOWixYqloj/MsV1JJHxr+mRiAXxByRy5uRTUSVOj7PBbxeSv+vxvpzSCgi
 nr0PBZbQyHCA9ohmuZZcpEFtGYdrVbdwqJ7qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745591025; x=1746195825;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/ujgAFLjRhkWvT0jXJVoYdEEW7ZuWTpv/Ha3rgiOx0=;
 b=mACP33hQGAoiwwiojCFDBkidL3XNqnFgl+FA63cwABSva4EyhnDFXRydu1jsdy+Sfs
 ZJfGhh6Pahn80ncjnasTRyZxFICQryYm89N1w6Ro47l2+SashZYzDCW7D74VQyU0hW1k
 ijo6XvFBpFAptJRPK05sxV6l2FS+D/0KoI+ZS7yBcLdvXvm7EVe016R2BaPiztXKYCeC
 RuImLcOaL0mX4HP7rhPp2KVi/mcipI3bRLAiwm2D0LKwv95kEtsrsH1umZflvXJ/1CAe
 M5I6lhRi3kGQ/6XxH3Qdz7dTGPhrFsuC6ksAwwa/0MXwUXBaClLyd/LLYr7F7tfr5mPz
 OOPA==
X-Gm-Message-State: AOJu0YyY+lGqPEr2PXD3S87Dfy0TkK1JopVAPIUbbMDagllnTwnBwz8O
 y7n+4W1XMsSz7mPuRdgnkVX+ketQ65+Zoo0AQpNHuMfA4k7rXCoXNgx+c/LkrT48z4lhsyZKQI9
 1wlo3WXYCH6FCh/OtmgqHvlnPNS1EjhC5S135YhM+eS6yopfmY2E=
X-Gm-Gg: ASbGncuoyTFLlY7Tv8BQrIKhexUtt8xkoJTrqNd0Ctkgl85RJtf9MbMJwKA6jw+g0NH
 /Hiu7aJLDVw0LBZPlykPKM6JWfu5MVuBKrckCd5EY9K2htacQKE37+50yyAqdY6zlsJNTPoSzqS
 OpWs+Om5rTjx73vkDvZsf1BgIoHVzSnKFAWMAq8pUr1kdADrnx0MmSOIU=
X-Google-Smtp-Source: AGHT+IGE7DL4hO7oa6U7hSk30LvOFhODIarvYwFO4/Mc5yM/6UXvC4sncKSEYFamkdLz5eDI4f2yi327TsrGZYcXz38=
X-Received: by 2002:a17:90b:3909:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-309f7e9eab0mr3826075a91.31.1745591024647; Fri, 25 Apr 2025
 07:23:44 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 25 Apr 2025 10:19:21 -0400
X-Gm-Features: ATxdqUHLmi8ORDVEo-1iOD2ln8yfxfSJH60V-OpdTlaGEdRcOoM2bh27PnHSA28
Message-ID: <CAJvnSUDdkMSqTGJfA6ZVWymBKDx883rAd2hAMT-=AdsiqdFazQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - April 24, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f297d506339b148b"
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

--000000000000f297d506339b148b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
April 24, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Paul Szczepanek

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* DPDK Prague will be held on May 8-9
   * Due to overlap, we will not hold a DTS meeting call on May 8, which
would have been the next regularly scheduled meeting
      * Patrick needs to cancel this on LF events

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* RTE_FLOW email thread has some updates, including Thomas=E2=80=99s sugges=
tions
for test coverage and Dean=E2=80=99s new rough test plan:
   *
https://inbox.dpdk.org/dev/CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJ=
w8w@mail.gmail.com/
* Review discussion:
   * HIGH PRIORITY:
      * Shell refactoring patchseries:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34865
         * We really need this done - Patrick has blocked out his 3pm-5pm
today to get this reviewed and tested
   * Medium priority:
      * L4 port # packet matching:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34805
         * Patrick to review/merge to next-dts
      * RSS testsuites:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34713
         * Has a partial review - Thomas will submit a new version
         * Dean is also looking through this testsuite as it pertains to
flow rules
      * Tmp dir and dpdk tree dir:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35049
      *    * Low Priority:
      * Nick submitted his RFC for adding performance TG support:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35097
         * TG abstraction structure is up for discussion and can be changed
         * We will start writing the single core forwarding perf test while
we wait for reviews
   * Merged patchseries:
      * Port_stats testsuite has been merged
* Old testsuites:
   * Patrick rebased/updated and resubmitted the port_control testsuite.
But I found one more change which is needed just now - can submit that
today.
   * The other old patches from Jeremy have been re-tagged to =E2=80=9Cchan=
ges
requested=E2=80=9D on patchwork, and Patrick will be working through these.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* There will be a =E2=80=9CBirds of a feather=E2=80=9D session at DPDK Prag=
ue, which we
could suggest a topic for:
   * Idea #1: DTS Testsuite API/module. What functions are currently
exposed to testsuites, and what others can be added in the future?
* Next meeting is May 22, 2025

--000000000000f297d506339b148b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>April 24, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vizz=
arro<br>* Paul Szczepanek<br><br>##########################################=
###########################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* DPDK Prague will =
be held on May 8-9<br>=C2=A0 =C2=A0* Due to overlap, we will not hold a DTS=
 meeting call on May 8, which would have been the next regularly scheduled =
meeting<br>=C2=A0 =C2=A0 =C2=A0 * Patrick needs to cancel this on LF events=
<br>=C2=A0 =C2=A0 =C2=A0 <br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>Patch discussions<br>* RTE_FLOW email thread has some updat=
es, including Thomas=E2=80=99s suggestions for test coverage and Dean=E2=80=
=99s new rough test plan:<br>=C2=A0 =C2=A0* <a href=3D"https://inbox.dpdk.o=
rg/dev/CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJw8w@mail.gmail.com/"=
>https://inbox.dpdk.org/dev/CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNki=
Jw8w@mail.gmail.com/</a><br>* Review discussion:<br>=C2=A0 =C2=A0* HIGH PRI=
ORITY:<br>=C2=A0 =C2=A0 =C2=A0 * Shell refactoring patchseries: <a href=3D"=
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34865">https://patch=
work.dpdk.org/project/dpdk/list/?series=3D34865</a><br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* We really need this done - Patrick has blocked out his 3pm-=
5pm today to get this reviewed and tested<br>=C2=A0 =C2=A0* Medium priority=
:<br>=C2=A0 =C2=A0 =C2=A0 * L4 port # packet matching: <a href=3D"https://p=
atchwork.dpdk.org/project/dpdk/list/?series=3D34805">https://patchwork.dpdk=
.org/project/dpdk/list/?series=3D34805</a><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* Patrick to review/merge to next-dts<br>=C2=A0 =C2=A0 =C2=A0 * RSS t=
estsuites: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D34713">https://patchwork.dpdk.org/project/dpdk/list/?series=3D34713</a><=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Has a partial review - Thomas will s=
ubmit a new version<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Dean is also loo=
king through this testsuite as it pertains to flow rules<br>=C2=A0 =C2=A0 =
=C2=A0 * Tmp dir and dpdk tree dir: <a href=3D"https://patchwork.dpdk.org/p=
roject/dpdk/list/?series=3D35049">https://patchwork.dpdk.org/project/dpdk/l=
ist/?series=3D35049</a><br>=C2=A0 =C2=A0 =C2=A0 * =C2=A0 =C2=A0* Low Priori=
ty:<br>=C2=A0 =C2=A0 =C2=A0 * Nick submitted his RFC for adding performance=
 TG support: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?serie=
s=3D35097">https://patchwork.dpdk.org/project/dpdk/list/?series=3D35097</a>=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* TG abstraction structure is up for =
discussion and can be changed<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We wil=
l start writing the single core forwarding perf test while we wait for revi=
ews<br>=C2=A0 =C2=A0* Merged patchseries:<br>=C2=A0 =C2=A0 =C2=A0 * Port_st=
ats testsuite has been merged<br>* Old testsuites:<br>=C2=A0 =C2=A0* Patric=
k rebased/updated and resubmitted the port_control testsuite. But I found o=
ne more change which is needed just now - can submit that today.<br>=C2=A0 =
=C2=A0* The other old patches from Jeremy have been re-tagged to =E2=80=9Cc=
hanges requested=E2=80=9D on patchwork, and Patrick will be working through=
 these.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Bugzilla discussions<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* There will be a =E2=80=9CB=
irds of a feather=E2=80=9D session at DPDK Prague, which we could suggest a=
 topic for:<br>=C2=A0 =C2=A0* Idea #1: DTS Testsuite API/module. What funct=
ions are currently exposed to testsuites, and what others can be added in t=
he future?<br>* Next meeting is May 22, 2025</div>

--000000000000f297d506339b148b--
