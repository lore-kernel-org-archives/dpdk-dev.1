Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1144D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 09:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9008C40270;
	Tue,  9 Dec 2025 10:45:08 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 998674025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 10:45:07 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8823d5127daso56008656d6.0
 for <dev@dpdk.org>; Tue, 09 Dec 2025 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765273507; x=1765878307; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=91b6vy1gwZeZKD4dneFdPQEzc1LXPWiILYRE5gezMqo=;
 b=dFmI28k2uFC9RMwjD8cvVTnh/gUUOQhvX4egcefNggXueA2VBtkoVui/3iuC4+CCGb
 8CLg8/sPiZxITAPXsNzM628l7/gpwbjQMZgL9+rAd0JQPtbn1ZtluGhAtIXgzmOUHxFK
 r9TrH54qiP9PC8eAd27D789k7pAzWSO6rfS00oSlF230CtwBDHwg6fYzE/dSOx5f70e/
 NJUStbKMX4ZZ3SOHrn9dpcs8LPQ4D9PhjtUBYjW1QdFzB7tgxwy3+M6FXpex+Pv9snnV
 x6MK+P8mHTG4qJwcKHflYqzfcPP6MCHW6r8Dfr6LaK2lcGmGZckK4iBN3n2Um/OqK7EE
 11Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765273507; x=1765878307;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91b6vy1gwZeZKD4dneFdPQEzc1LXPWiILYRE5gezMqo=;
 b=Zoxz9NdFdYFxqlDVOaJKEHakg1pxA+V/QnRFf7C58Vg3Gp/9vo2uST289CNy/WqdDf
 usaPCQ593Nt8VtjowrTyyGjUacamFJgNAoKP7j+kWRr+vWJpjZtzwjct5fkFzq1V7CpR
 A5mcfMlK2cDE8qhHhdyRhOZ46EY51W3+X1cNMyfD/BIxUJDrSO5AVsOuGQFZveGYjqQl
 Vzi8DN1n9kpSOcT02/okvDrWEl77RLXHFj+/HDkULG/1DQUbIOb8PwBXLYn7FuwDikyb
 VO9+ch6q06Kq8gXsYoHnIYYxvDC1fiXc6QDrPBNfuF74qgGGSGhBjxt4fPUDbNUu8SVz
 tyeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI6hTLhSgYX8rqKunLKyugFIaPrI4JVo94YB4tVdMMoJSxXAa3BgtojQ68tHgTMnG+l14=@dpdk.org
X-Gm-Message-State: AOJu0YzOcjOUK5mOj0HhMcT9i8MD0eEO0mAxUfGKrgpXL8fnWMxRoJC0
 8Plv/rCvTYxW/pd0vO7e0vykCDv7G7/For+2eGV/TBoBsLIzd2wtOw+DPKmPf7phSaowvJz9vfw
 c2K5ZF1Um6bG8mnBcHf4ZVtaxps2nP6o=
X-Gm-Gg: ASbGncuADkpEG+QVUTAQNWpTbg4YNYVXX/swyeX5qfkvlFgE8amqaD7DPipNKo97afq
 ogw+mIbUGt0Wtx5p6Ex0aTO6hoBCKvZGwykkAEEf47Mt0RNGpcg1ZWvGLYoGYhHv2o7k3vUGc7z
 aLTkq2P5FklK+hOy0UGkxnOlIWUwqv2X+aEKRoj18NwTeN6uE5JxX/AkHrtR0YGCsx7iG3aLeD4
 FfehchXgU4Jvvb1EDFWq01lTpYjmfxGHShrlvbunDLvUGCcysGEK8PR/i8BeQNzGir048WG
X-Google-Smtp-Source: AGHT+IHtyqUK/xO0j42pI0oX53qB/5VVRS7oVWsuN2yTTkWomEyNW6LKW6GA68UVwF0n1ln7dxZlzl9kxazuKjBzNfc=
X-Received: by 2002:a05:6214:e8e:b0:882:6797:3a67 with SMTP id
 6a1803df08f44-8883daba866mr179160806d6.13.1765273506877; Tue, 09 Dec 2025
 01:45:06 -0800 (PST)
MIME-Version: 1.0
From: coolwilled <coolwilled@gmail.com>
Date: Tue, 9 Dec 2025 17:44:55 +0800
X-Gm-Features: AQt7F2rJjJWjdEWau9yxFA9U2MLXr6EHSk4-YgW_i8igAkG5X-Xf7SlYGRponhI
Message-ID: <CAL2ZP-DO8FuVfQ3TyHLtnw8sXLLa6UW_fX-m6Tb8HO33s=S9NA@mail.gmail.com>
Subject: Ask help for DPAA_SEC: test_pdcp almost all cases failed
To: hemant.agrawal@nxp.com, sachin.saxena@oss.nxp.com, g.singh@nxp.com, 
 dev@dpdk.org, users@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000004f164f064581c403"
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

--0000000000004f164f064581c403
Content-Type: text/plain; charset="UTF-8"

Hi, NXP and dpdk.org users and developers

Did anyone run test_pdcp on DPAA_SEC ?

I have a NXP LS1046A board.
I have configured DPAA sec and 4 dpaa_sec crypto_dev can be found
in rte_eal_init().

I run dpdk-test from dpdk.org git commit = b287e404643a  (24.11.3)
and almost all cases execpt one PDCP status report case failed.

I also run app/dpdk-test-crypto-perf  throughput  test with dpaa_sec.
It only measures throughput and doesn't check  correctness.

I find the session is created with rte_security_session_create() in
app/test-crypto-perf/cperfops.c for CPERF_PDCP.
And session is created with rte_cryptodev_sym_session_create()
in lib/pdcp/pdcp_crypto.c .
Which type of session should be created ?

How the test_pdcp can succeed in LS1046A DPAA_SEC ?

Thanks a lot.

--0000000000004f164f064581c403
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, NXP and <a href=3D"http://dpdk.org">dpdk.org</a> =
users and developers</div><div><br></div><div>Did anyone run test_pdcp on D=
PAA_SEC ?</div><div><br></div><div>I have a NXP LS1046A board.</div><div>
<div>I have configured DPAA sec and 4 dpaa_sec crypto_dev can be found</div=
><div>in rte_eal_init().</div><div></div>

<br></div><div>I run dpdk-test from <a href=3D"http://dpdk.org">dpdk.org</a=
> git commit =3D b287e404643a=C2=A0 (24.11.3)</div><div>and almost all case=
s execpt one PDCP status report case failed.</div><div><br></div><div>I als=
o run app/dpdk-test-crypto-perf=C2=A0
throughput=C2=A0 test with dpaa_sec.</div><div>It only measures throughput =
and doesn&#39;t check=C2=A0 correctness.</div><div><br></div><div>I find th=
e session is created with=C2=A0rte_security_session_create() in</div><div>a=
pp/test-crypto-perf/cperfops.c for=C2=A0CPERF_PDCP.</div><div>And session i=
s created with rte_cryptodev_sym_session_create()</div><div>in lib/pdcp/pdc=
p_crypto.c .</div><div>Which type of session should be created ?</div><div>=
<br></div><div>How the test_pdcp can succeed in LS1046A DPAA_SEC ?</div><di=
v><br></div><div>Thanks a lot.</div><br><div><br></div></div>

--0000000000004f164f064581c403--
