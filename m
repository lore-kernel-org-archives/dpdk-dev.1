Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E667C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:12:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5156F402BD;
	Fri, 14 Mar 2025 00:12:34 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id BB9BE4025D
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:12:32 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso3171638a91.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741907551; x=1742512351; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Rp3/F5HmlyCrHBmGl9UnK27GuFZTwq3LxH8dzmKEWLk=;
 b=CRHQo1jkxIOV2V8KHMxIXfXWGfEgkrsav4Vr5uScA41GC00Bwn5J7fb9m41B2pSQbf
 QxNh8T6yOanOfJwsgFk1ZU875NzMYqZcavwEKDtjethDyrGtu4RLSsBzrI7XavykBoDx
 O6YotVQ1dhfsWPMFfWToKgK8ttZ5FdMGAUOV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741907551; x=1742512351;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rp3/F5HmlyCrHBmGl9UnK27GuFZTwq3LxH8dzmKEWLk=;
 b=lRFM/T+DOAu5pv1MqRHS6dZO1l//YF8XnFQOUWXYnaTrzpAJF21hDHftOg3oCBb82h
 CoG8H7A+IHjsOxFEVeveHm6UebLgETGdH9LuxiiK5Cr4FfSM88fLqVWS+kIElkrjuGmK
 NgoLus9z7RKgslH6KFS8iOd7XiMomUGS8felbvR0951U/+NpXANjlSe2eJMNGdr6Dp5H
 SYs/Yv1gbP5u+Jx0j8v6xBpokHkcEmB1nRy2fe50Kz52N77YbSmk6EyHt6uSQTk15+4I
 78oRCbewSX0hM73NEarSIZ7fvcTH3KMSFQ3urvu30QzJ9qn6IB4dSU6TI8wUF0qS8eoi
 gQow==
X-Gm-Message-State: AOJu0YxY3x4SyzXmuLrL4ow0U3IklZFaGHrgTvw833/8SKbCs0NmnFnj
 VwbPeh8LeyfnCFAypO87npsXXuY//NKjWfn7pOWIUd8sItkgrqVI9i3uFtyS2Jd5TGt1zqHqbjV
 6t8prHmQ5ITejDVVtxSvW9abIQlkZv7M0UAegDPnMlnGVwyvBQ0MwGA==
X-Gm-Gg: ASbGncsgLIUQSojG5/WCVVxcnx5VmU9ssWQ8ZF7GABXFti0VO6/Qe/JwOTQZP1DR1SU
 kPX+UwOdiCet7wxe2ju3JHl4NIi1tZFHNxd7qrteMnSYguB4svpXvPjyiR+Tum0TOqs9W1iQC3F
 AZRSTf0OtgfelX2JoMjl4kygDy4xg50gKfOfmdwTdgiz1Tgw7BL8mFM+tWnvo=
X-Google-Smtp-Source: AGHT+IGhp7Imkkr138UDYaYsK8ukDXaPIFSTeRU6R/Bnv+FvoJHqKLXzwlV60Xzd/mf9nfCwm9H+wL5VhpEbWQJiG18=
X-Received: by 2002:a17:90b:5688:b0:2fe:a545:4c85 with SMTP id
 98e67ed59e1d1-30151da0c0fmr399935a91.27.1741907551169; Thu, 13 Mar 2025
 16:12:31 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:08:47 -0400
X-Gm-Features: AQ5f1JoZCrer8X6A1F9Esy39FtqkGpVO5xSBIavpIytLi6sYaFe6YMiM4bXdt7o
Message-ID: <CAJvnSUAxrYVaiSQnAdQ_h+7ZfAOcWBWkZC38=K8AKAWx4bpHqg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - January 30, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d1ca2c063041746d"
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

--000000000000d1ca2c063041746d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
January 30, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Thomas Wilks

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* Async sniffer failures
   * One issue was lack of ip link up in testsuite setup. This is resolved
now with latest next-dts commit.
   * Unclear if there are any other issues.
* We=E2=80=99re ~20 patches away from a healthy backlog - reviews are neede=
d
* Re-asses DTS 25.03 Roadmap
   *
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWt=
xnko/edit?tab=3Dt.0
* Discussion on raw payload comparison
* DTS usage in cloud environments
   * Checked with Azure - they cannot provide an L2 network for testing
   * Will discuss an implementation at a future meeting

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Rework topology config
* runner.py rewrite
   * Luca has a runner.py rewrite which attempts to improve separation of
concerns in the framework. Creates new class - testrun - configures runtime
and testsuites. Testrun class spins up testsuites and testcases
independently. It is a state machine instead of a deep call stack.
      * Stores current state and context of dts, updates as we go.
      * By creating a context, we improve the developer experience, as we
also enforce a division between the framework internals and the test (the
testsuite writing plane)
      * We need to ensure that the API is consistent. Because the framework
internals are constantly changing, we do not want developers to have access
to these (like the nodes).
         * Only topology for a particular testrun is available for a
testsuite
         * Testsuites will not =E2=80=9Ctouch=E2=80=9D ports not a part of =
the list of
ports they need
         * Tg shell and testpmd shell will get all the information they
need via the context
         * No need to differentiate between tg nodes and sut nodes (a node
just has hardware information)
         * Runtime parameters for the tg or dpdk app are contained within
the testrun (instead of the nodes themselves)
         * Will reduce duplication and simplify the testsuite code.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* High level parallel func testing discussion:
   * * Next meeting is Feb 13, 2025

--000000000000d1ca2c063041746d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>January 30, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vi=
zzarro<br>* Thomas Wilks<br><br>###########################################=
##########################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* Async sniffer failur=
es<br>=C2=A0 =C2=A0* One issue was lack of ip link up in testsuite setup. T=
his is resolved now with latest=C2=A0next-dts commit.<br>=C2=A0 =C2=A0* Unc=
lear if there are any other issues. <br>* We=E2=80=99re ~20 patches away fr=
om a healthy backlog - reviews are needed<br>* Re-asses DTS 25.03 Roadmap<b=
r>=C2=A0 =C2=A0* <a href=3D"https://docs.google.com/document/d/1doTZOOpkv4D=
5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0">https://docs.google.com/do=
cument/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3Dt.0</a><br=
>* Discussion on raw payload comparison<br>* DTS usage in cloud environment=
s<br>=C2=A0 =C2=A0* Checked with Azure - they cannot provide an L2 network =
for testing<br>=C2=A0 =C2=A0* Will discuss an implementation at a future me=
eting<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Patch discussions<br>* Rework topology config<br>* runner.py rewrite<br>=
=C2=A0 =C2=A0* Luca has a runner.py rewrite which attempts to improve=C2=A0=
separation=C2=A0of concerns in the framework. Creates new class - testrun -=
 configures runtime and testsuites. Testrun class spins up testsuites and t=
estcases independently. It is a state machine instead of a deep call stack.=
 <br>=C2=A0 =C2=A0 =C2=A0 * Stores current state and context of dts, update=
s as we go. <br>=C2=A0 =C2=A0 =C2=A0 * By creating a context, we improve th=
e developer experience, as we also enforce a division between the framework=
 internals and the test (the testsuite writing plane)<br>=C2=A0 =C2=A0 =C2=
=A0 * We need to ensure that the API is consistent. Because the framework i=
nternals are constantly changing, we do not want developers to have access =
to these (like the nodes).<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only topo=
logy for a particular testrun is available for a testsuite<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0* Testsuites will not =E2=80=9Ctouch=E2=80=9D ports no=
t a part of the list of ports they need<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* Tg shell and testpmd shell will get all the information they need via =
the context<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* No need to differentiate=
 between tg nodes and sut nodes (a node just has hardware information)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Runtime parameters for the tg or dpdk a=
pp are contained within the testrun (instead of the nodes themselves)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Will reduce duplication and simplify th=
e testsuite code.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>Bugzilla discussions<br>* <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* High level parall=
el func testing discussion:<br>=C2=A0 =C2=A0* * Next meeting is Feb 13, 202=
5</div>

--000000000000d1ca2c063041746d--
