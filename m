Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF8FC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:28:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CC9F402AC;
	Thu, 13 Aug 2026 16:28:33 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id AF7DE40298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:28:31 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1517718a12.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 07:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786631311; cv=none;
 d=google.com; s=arc-20260327;
 b=OViKoATFyQrsSUjg3voFZNEgTopyla6wrO1al3Zqi9eyGtpaIby141C7SBOCcdDJDf
 nyx2epnjPf0YmSTx6gBpNbNj3PUa8pSSldypevjuN5Nay9m0flWuFdv6MkLAOv+qhPhb
 BBPy0d5iSDmtSELgz1ag79DQrKaCCwAM3XpDuqiDznbaZUkzzYs6aQTQliIRQ+ckfase
 GmjxqsWg2Q6R2tCP3NSQWN1luZ0PQsvL+au30geq8eySazoCDVl+IOzuYW4smUGhPSCv
 YuIwQM8TNoUJuNVAwVkSbYGW9br8R7if6NKyzFZO8cQlQ/JxzYoUplP40G6wsXcrbqUJ
 Ke0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=C+2mUYCrqvqqtDlJO0N1fUAZVCw3A490B1GYh2yJAzM=;
 fh=OsFbtGPcsVwS+friAQottTRnk+MtljbA6+PlBAMSCBE=;
 b=hFKwa1HNupHfzMvutFEFHqzae+EyB9nPwKBh0dxZ+3V6e21d2+MPU6+lUqFUyD4PHL
 NMuku48YKOWliv5ze1zcx0hDeyr8a3L1si8pUIBuNHhOwI2BU0bL+yAYu/j7qQ52G4X2
 UaXS1X4+OQ7yHrQzubwC5/Xcq9KlA+dSxmcZ44mSK4CTjAHoWA9vacJNmkFgAB80v7lK
 305ZYKPUgoWLtcLxTXFNxYKeoGvHR2d1oI9Lh4kkDwHQeD1djEVU7MGHJBOrd8E5/e3w
 isQI8ywwEHRbK16q9+EyUkbmOLUz0kt1nEmsuMQSZoErH98zvvIVwPpsdpxZsj1mGear
 pJGA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786631311; x=1787236111; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+2mUYCrqvqqtDlJO0N1fUAZVCw3A490B1GYh2yJAzM=;
 b=hi+QTa4zpVrybQDY9eoYZKNZTk7iY/krQ/ZRAiT1vZ9vvAvgean5GrHR0p/PL0lKYa
 FByb5UcKOJQRotmDx2w0e8CI2oD4to5paXxsHpI66M0pCrsgLTZyXle84Xz0VjUgNTou
 mHi9vFUMIVk1zvb40XQNzMHxBZhzTg4KfNt1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786631311; x=1787236111;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C+2mUYCrqvqqtDlJO0N1fUAZVCw3A490B1GYh2yJAzM=;
 b=UJyQYeDagHDpyjCpITVsS7yVj4BU+VNN4mfvX+km+6L74diyx7SxZ3l0ofmBlKxalN
 985QALJOwbcLNjmLDANeNWb49tC8YgdCWvFD1GqDQ1JYwliLja/Jv2qfOvh2TrYky3Mz
 DF2S9dwS6qu8gMGI7GGUfVIcWUbTxHC4OxQK/d8/Yl3QFUIsfQ72H/THymx7yKphNewP
 pbrENkeIUoFyTrH70JujsA/cRIWCTr2VX6FwtA6xEJFis21EPilq89EBOeEG8MHpxsPE
 E9futJfEA+ozVGkkKeURCZI8xqT9MbdAXNfQgYxl8uXEM723AHgqSpAdWRDWCbbn0VNZ
 /Zkg==
X-Gm-Message-State: AOJu0Yx2YQ9XqTNH9sHpEezXwbSwNlSOJyzujemZI8xUpB7XD4Vu0IKn
 cGBGKYZIog/9sOG5aRGX0HKRJRdHxCiT5T/Si8Zv0mrbsvooCT2HyFL/I64gJFfh57Fm/+bJP1O
 MXDsWRGdhtFjzuhBdB48IOpsmT1YciKuixaMECL8ulpGxfXi+tESytLo=
X-Gm-Gg: AR+sD12zSUDHc9bsS3k8g2iKVRIYiwRsmGf5ZX0sTzqGlbckRRM1qZ3w4QEQ8XKr3cx
 6Va25WnGEmMXqZlY07Mj3f+H45xxYOx7wPs0v2Q1n7A95Rqdekykt2l0bROsC4e31hqY1Vgva5y
 8UDkLRg8WPv+i7fMFJRWlaK6EJoqw7zGrfGO/hTAxFA82D/ia+NYSpI9KhaTVN6SyM8iOy0ZvkB
 fVSGUqI646rvjyWPu/5LJoMfTmsnadaWLwqkHR9LsgZFyYcURCXMUudaz6Q1nGNxh4Xoro4muX1
 +iXjzhClSGSPCvJgU2nfYxxq6i081haCMaP/riOjtg1JAs+j5cZUaLaAxQMoJEg+DMFBEw==
X-Received: by 2002:a05:6402:1e8f:b0:698:1973:1daa with SMTP id
 4fb4d7f45d1cf-6a3806210c7mr2577562a12.18.1786631311134; Thu, 13 Aug 2026
 07:28:31 -0700 (PDT)
MIME-Version: 1.0
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 13 Aug 2026 10:28:19 -0400
X-Gm-Features: AUfX_mwwoEg1W5B1Sj65pPD_51bqnC9trj0wJMBrz2PcPdG2JIDQEp2QIdbdHoQ
Message-ID: <CABJ3N2UDCcJe9uJd-FV_1khiKy0PWy4_H69jd=FdqaHKb1vYfQ@mail.gmail.com>
Subject: DTS performance test coverage question
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, 
 Akhil Goyal <gakhil@marvell.com>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <patrickrobb1997@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a51fcf0658ee845b"
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

--000000000000a51fcf0658ee845b
Content-Type: text/plain; charset="UTF-8"

Hello All,

    As of now in DTS, the current options for performance tests are limited
to single core forward
performance and cryptodev throughput testing. There are a number of
performance tests in
old DTS that we were looking at using to potentially broaden the amount of
DTS supported
performance tests.

    The question to the community is, are there additional performance
tests in old DTS that would
be beneficial to port to new DTS?

    Furthermore, are there performance tests that are desired that do not
yet have a dedicated test suite
in old or new DTS?

For example, some test suites we were looking at as potential candidates
include:
 * virtio_perf_cryptodev_func
 * eventdev_pipeline_perf
 * rx_timestamp_perf
 * pvp_multi_paths_virtio_single_core_performance
 * pvp_multi_paths_vhost_single_core_performance

Cheers,
Andrew Bailey
-- 
Andrew Bailey
Senior Developer, UNH IOL
21 Madbury Rd., Ste. 100, Durham, NH 03824
abailey@iol.unh.edu
https://www.iol.unh.edu/

--000000000000a51fcf0658ee845b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello All,<br><br>=C2=A0 =C2=A0 As of now in DTS, the=
 current options for performance tests are limited to single core forward</=
div><div>performance and cryptodev throughput testing. There are a number o=
f performance tests in<br>old DTS that we were looking at using to potentia=
lly broaden the amount of DTS supported <br>performance tests.<br><br>=C2=
=A0 =C2=A0 The question to the community is, are there additional performan=
ce tests in old DTS that would<br>be beneficial to port to new DTS? <br><br=
>=C2=A0 =C2=A0 Furthermore, are there performance tests that are desired th=
at do not yet have a dedicated test suite <br>in old or new DTS?<br><br>For=
 example, some test suites we were looking at as potential candidates inclu=
de:<br>=C2=A0* virtio_perf_cryptodev_func<br>=C2=A0* eventdev_pipeline_perf=
<br>=C2=A0* rx_timestamp_perf<br>=C2=A0* pvp_multi_paths_virtio_single_core=
_performance<br>=C2=A0* pvp_multi_paths_vhost_single_core_performance<br><b=
r>Cheers,<br>Andrew Bailey<br></div><span class=3D"gmail_signature_prefix">=
-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"=
gmail_signature"><div dir=3D"ltr">Andrew Bailey<div>Senior Developer, UNH I=
OL<br><div style=3D"color:rgb(158,158,158)">21 Madbury Rd., Ste. 100, Durha=
m, NH 03824<br><a href=3D"mailto:abailey@iol.unh.edu" target=3D"_blank">aba=
iley@iol.unh.edu</a><br><a href=3D"https://www.iol.unh.edu/" target=3D"_bla=
nk">https://www.iol.unh.edu/</a><br></div></div></div></div></div>

--000000000000a51fcf0658ee845b--
