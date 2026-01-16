Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D2D4660C
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 10:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C37B42DCA;
	Fri, 16 Jan 2026 11:45:30 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 3582442D90
 for <dev@dpdk.org>; Fri, 16 Jan 2026 11:45:28 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-88fe44cce7eso21111356d6.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 02:45:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768560327; cv=none;
 d=google.com; s=arc-20240605;
 b=GlP9LQ5Gcg5hT3cpw4E5gYLsE2E7MIDuMd9xxyDR/m2kvHqxdDNV5o9nuHKEqG1A1z
 WKTDIPGpcQZORLQ/CtcanwrPM3P+UvcftO3B6pw7NAhRNnoO9IO+djP6UgxCCRncx2rS
 iBNXDQKHONqJc3YTlgTEEPtzJ3Bgkb93HTRp2lpx8ItEBPAUYTFhlM4OTBkbi8kikdl+
 wVm17ZvmPdzCM9NRr2HRHl9TC7HD/Y2VcrF6jHZNRVAATdaeqH/C7WU/XjRZQwaF4jSd
 Z8IVSGa+bFY1yeYl/qOthwnp/vAcihc1jf1MU1h/vhPoxbTK7qCEnBGXc+iaZiwiQwJa
 8xtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IfOlDc8ZUBS4hif9IdA0vNVpFJvzXL9zQbDnettTo50=;
 fh=RpxBw4p1ryaZNr5hhNl+32afjHzvDJn4s94u0eRqSRU=;
 b=HD6msTyiJtWtbD67r1y/sqb/oatPMECGQUfuMi5sJpoZ3C7D6BELS1fv8e6C/7xQps
 mqUdUjwdy7Ef9EBpyH8dgLyWLwJPOsDeYA7C+7/YqEpJwJmOuY5l64r9TC+KD1KnOeC8
 WB9DNzlX/HwmF1BX0VjGed8ypIcgS/0rRhTNiWuXoQa5VvkbNgjpvp3ZIJ+nkVrFSMln
 oMawga4Srb8lU8v2M/Ej+hLCpWgGoQm5nrf1yfy7EtPxo4tgRNccYBwHBqea/eWEIZO8
 GXMhiwv11d8g0JnxUFq38i9eDQtJ2VJcS+4gAV2sQpkdciCfyBOTZ1245YPSBcW562og
 QcAA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768560327; x=1769165127; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IfOlDc8ZUBS4hif9IdA0vNVpFJvzXL9zQbDnettTo50=;
 b=Bgun72x0dgM5aXF2lKJb3cGZ8gz7SYEXwAp+uWGJDeABF3ZZ4tMqCBAYFTZdCUP6BW
 92rA8uYezr1m2yNDSqhZ68rSrCZ9FVN9C5skeiCq3jqtrKS2BCwLPwmrAsOkNlySPwsj
 h4o6RD2xBJAagiapWtZkTNsAt2p52WezuyorK9zGl58cHMaQ3+N7pdIohDSyzcwXu75P
 fnevi+TxKbAQNJoJBK3R2iFOTUsfVP0SaPaWn+uKQrAlEuubhIxOuFfd+Qs0fZBK+9P+
 eq48yHFgd+PXCZv6IjW1eYEdKUWd6AOu6yEnZ8VtJrppbeAzdbGEHWJezpopCnSAGv+5
 /Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768560327; x=1769165127;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IfOlDc8ZUBS4hif9IdA0vNVpFJvzXL9zQbDnettTo50=;
 b=grlnNPAn/H+ugxJFCfjt0SfzGUS21z8bHgFQvX+NwHY8hSuq6ae5FdAFM6YRVpQN3S
 Lk1ThjrH4a99hVAjqDylNSyhtwsCnkUQu6wQcbenaSO8CLydjDs1/+gqdhq+L6rk2Gi+
 KjRjGzHwgef2bqj4EZwsdAUpfafS72exNIB/SJxfl53FSNeZhzRVmjVIYxeh0kZFBuBj
 e35xCMMyoSaqmj1mpebcEUXJf1zHAeA9zXFcmXjGTYed7ATHJ/4a9rw2MXEAlMhKSADW
 /DlEYWdNl5q9t6H3RlXbeQhr6UhfJLJowJK8OxdJEi3csuvS4XNyEYgJ1XJeKPy04HQK
 bvtw==
X-Gm-Message-State: AOJu0YyxeAuCUFruNAp087OMzFLTZFxNX90HZTNwY4uNJVtsDm+E8jrb
 DmBy7VgjPMQDDrKEYQ3Zjg9tsLrGPp2faAh+GOQWuJBDBaGjYilZOnMPuMy63N3iNHOLR6fj3vO
 +td1+mYMs1V9D19QHC6039lOMq20zGiTXkqwu
X-Gm-Gg: AY/fxX70PHmosvAU8WKetJFexIlNFqqHt1U4N7P8aoqtpZPdFmowvY+xsAhQ65v6Lc3
 uDhtapf4RV6vmVci8bg3hceDftDGUaTVfu+Du2MwrB7HVcWv8i75a7JrQk9w5FXaCbqL9zMamj2
 IxAGlmmxqM2Ogdu1KmfNgklZP6A8CQSAsd8jaHpY6I5hGtZVR9XSzANoyId1Bzq+RkCD3fZAGz0
 Htl5gukSLjxuXL4B4MNQcg3QrTKp6n6n4XOYvFPb1tQIzVop/qFcyNEWqlG8VJ5H1JiVuZtMWTL
 gw2cE9VL+Tv5YTV7MPek1ABi8LFEPSdK8FMTL4kQ3aNvvqjZn+oSXlr3pg==
X-Received: by 2002:a05:6214:246b:b0:880:2a49:7047 with SMTP id
 6a1803df08f44-8942dd70cffmr31627246d6.35.1768560327365; Fri, 16 Jan 2026
 02:45:27 -0800 (PST)
MIME-Version: 1.0
From: coolwilled <coolwilled@gmail.com>
Date: Fri, 16 Jan 2026 18:45:15 +0800
X-Gm-Features: AZwV_QiU3CZ7H9uDFvL_lYEC3LqP4qJPQIHjfPuhDQd_DZxFUZf0M2QaOaFhTJE
Message-ID: <CAL2ZP-A=cnXozqacMbDUKd15KgHifSmBjqNDN+o340yJ+3t99w@mail.gmail.com>
Subject: Bug: crypto_snow3g failed in Auth snow3g + Cipher snow3g
To: dev@dpdk.org, users@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000013981e06487f0a88"
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

--00000000000013981e06487f0a88
Content-Type: text/plain; charset="UTF-8"

Hi,
I run "pdcp_autotest"  with --vdev=crypto_snow3g in app/dpdk-test in dpdk
v25.11.
When i = 42 in run_test_for_one_know_vec() in test_pdcp.c,
It is PDCP control plane Auth snow3g gen + Cipher sonw3g enc,
the case failed because the last 4 bytes is cleared in
last for() loop in line 167 in  process_snow3g_cipher_op() in pmd_snow3g.c .

It can be fixed with following change:

diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c
b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index b3c3b05a8a..45a8be5fc8 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -157,7 +157,7 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp, struct
rte_crypto_op **ops,
        for (i = 0; i < num_ops; i++) {
                if ((session->op == IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||
                        session->op == IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &&
-                               ops[i]->sym->m_dst != NULL) {
+                               ops[i]->sym->m_dst != NULL &&
ops[i]->sym->m_dst != ops[i]->sym->m_src) {
                        digest_appended[i] =
                                snow3g_digest_appended_in_src(ops[i]);
                        /* Clear unencrypted digest from

--00000000000013981e06487f0a88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I run &quot;pdcp_autotest&quot;=C2=A0 w=
ith --vdev=3Dcrypto_snow3g in app/dpdk-test in dpdk v25.11.</div><div>When =
i =3D 42 in run_test_for_one_know_vec() in test_pdcp.c,</div><div>It is PDC=
P control plane Auth snow3g gen=C2=A0+ Cipher sonw3g enc,</div><div>the cas=
e failed because the last 4 bytes is cleared in</div><div>last for() loop i=
n line 167 in=C2=A0=C2=A0process_snow3g_cipher_op() in pmd_snow3g.c .</div>=
<div><br></div><div>It can be fixed with following change:</div><div><br></=
div><div>diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto=
/ipsec_mb/pmd_snow3g.c<br>index b3c3b05a8a..45a8be5fc8 100644<br>--- a/driv=
ers/crypto/ipsec_mb/pmd_snow3g.c<br>+++ b/drivers/crypto/ipsec_mb/pmd_snow3=
g.c<br>@@ -157,7 +157,7 @@ process_snow3g_cipher_op(struct ipsec_mb_qp *qp,=
 struct rte_crypto_op **ops,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i=
 &lt; num_ops; i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if ((session-&gt;op =3D=3D IPSEC_MB_OP_HASH_VERIFY_THEN_DECRYPT ||<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 session-&gt;op =3D=3D IPSEC_MB_OP_HASH_GEN_THEN_ENCRYPT) &amp;&a=
mp;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ops[i]-&gt;sym-&gt;m_dst !=3D NULL) =
{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ops[i]-&gt;sym-&gt;m_dst !=3D NULL &=
amp;&amp; ops[i]-&gt;sym-&gt;m_dst !=3D ops[i]-&gt;sym-&gt;m_src) {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 digest_appended[i] =3D<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snow3=
g_digest_appended_in_src(ops[i]);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear unencrypted digest f=
rom</div><div><br></div><div><br></div><div><br></div></div>

--00000000000013981e06487f0a88--
