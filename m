Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B643EC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 03:34:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3DE640156;
	Mon, 14 Apr 2025 05:34:56 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 512C8400D7
 for <dev@dpdk.org>; Mon, 14 Apr 2025 05:34:55 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-301e05b90caso3809722a91.2
 for <dev@dpdk.org>; Sun, 13 Apr 2025 20:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744601694; x=1745206494; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9yFxJDTGvYdR63dOdoJRPbi6Oi9Dcvtt3T6WNg/REso=;
 b=Z8vzP/J6Gy9/BuWaf7CPz/mSVNKWma5XWNJdzjksqdSyeOnnYv9iRK9sVj3chOOrbZ
 2mW00xTIBT5I4Kr68IF2QpQ4z9IGrToyZBca4od5P0W8HL4hkxqBR3gM0VVlHLleGsl3
 JpRdavgMmOfOEN60SmKG1thOVNPBit6SGn+NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744601694; x=1745206494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9yFxJDTGvYdR63dOdoJRPbi6Oi9Dcvtt3T6WNg/REso=;
 b=vVQdlx8dPnVycTgOeCnDvU2HPewjoLjerpb6NY+Ciyb6kwSrgI1/LBrnyxB47joHnq
 9sqgOTQxPuUEccoiH+4uQwmYHX1dm1pNdFOi9G38hqSWLM33NIYhJayGmeb8YsSI80KT
 ILr7EYpLix2UY9qAUPpQgoe+zOH0CRnEtgbh1VbbQbW7yECjfYKqsSADPR7oDBU5qVKV
 WlfDYcnhMK8xV2muaYOqRpE44SZzbq2Bj94FPMIyMEL4VMnH7QGZOXl3T3mproB2Nd/p
 QfhXzjp+FbkNWBv6cwZGwBBQtEdeGjv3fMbCf6i2JX74d2FNmtyFqgwPpC1024760gDC
 eCUg==
X-Gm-Message-State: AOJu0YzC0zIges+0n9fiaQlj1A3OyOvImsEnUaTQXPwsY/RhsEmZM+lJ
 f9ZQf+nknep9R2g9qGhV9yNSYVgsa4MXCiCM2mzhUAJ0mCdYj77l5ABLcelNSm0UZSThuse2gsu
 vNp+W4F/2cq33D4zMrUqI/33rSeHSSW3YC+Q5yOgpOEDGd3k+
X-Gm-Gg: ASbGnctwgl/CKOrJBL+1ukKNlW8ffts9VLp7eLDYSfg724lFXHuFJY0JLhfTq1pXCTY
 nX79515+CxdW0g1CP+CMPxTBLhwrrcq82z8By8+K56kWL/v7zfGKXoquG8dw0C0zQG7ieD3R3IZ
 jpdYU9B8QsrSnd36uirKnErouuGIdAhtVrTUh7Mg==
X-Google-Smtp-Source: AGHT+IEfT/vloeyJps45fgmuvOnvkLOknH9PTxnAR9GsRhlEcaLRqQZrP7u4GwlrrMpgbc4GBLhiIOQgfkgiMu1XIjU=
X-Received: by 2002:a17:90b:58eb:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-30823784865mr16742403a91.35.1744601693988; Sun, 13 Apr 2025
 20:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240829125020.34341-1-alex.chapman@arm.com>
 <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250225153345.331216-4-thomas.wilks@arm.com>
In-Reply-To: <20250225153345.331216-4-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 13 Apr 2025 23:30:42 -0400
X-Gm-Features: ATxdqUHK7uLpcUYZnADelyHVZwa45pk_sOutLzRPw3xNEn5IOa-KSMnn_TEbTUY
Message-ID: <CAJvnSUC9yph2ZN3CG1N-F6ckB3XmZSKNBaS+=D4evwnjo+gzUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] dts: add PMD RSS hash testsuite
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Alex Chapman <alex.chapman@arm.com>
Content-Type: multipart/alternative; boundary="0000000000003ec9ac0632b4bc28"
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

--0000000000003ec9ac0632b4bc28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:34=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:

> From: Alex Chapman <alex.chapman@arm.com>
>
> Port over the pmd_rss_hash test suite from old DTS. This
> suite verifies that the 4 supported types of hashing
> algorithm used in Receive Side Scaling (RSS) function
> correctly. Them being DEFAULT, TOEPLITZ
> SYMMETRIC_TOEPLITZ and SIMPLE_XOR. This test suite also
> verifies the supported hashing algorithms reported by
> the NIC are correct.
>
> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/tests/TestSuite_pmd_rss_hash.py | 118 ++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 dts/tests/TestSuite_pmd_rss_hash.py
>
> diff --git a/dts/tests/TestSuite_pmd_rss_hash.py
> b/dts/tests/TestSuite_pmd_rss_hash.py
> new file mode 100644
> index 0000000000..d21e33456e
> --- /dev/null
> +++ b/dts/tests/TestSuite_pmd_rss_hash.py
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""RSS Hash testing suite.
> +
> +Hashing algorithms are used in conjunction with a RSS hash keys to hash
> packets.
> +This test suite verifies that updating the Hashing algorithms will
> +continue to correctly hash packets.
> +
> +Symmetric_toeplitz_sort hasn't been included due to it not being
> supported by
> +the rss func actions in the flow rule.
> +"""
> +
> +from framework.remote_session.testpmd_shell import FlowRule, TestPmdShel=
l
> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import NicCapability, requires
> +from framework.testbed_model.topology import TopologyType
> +from framework.utils import StrEnum
> +
> +from .pmd_rss_utils import (  # type: ignore[import-untyped]
> +    SendTestPackets,
> +    SetupRssEnvironment,
> +    VerifyHashQueue,
> +)
> +
> +NUM_QUEUES =3D 16
> +
> +
> +class HashAlgorithm(StrEnum):
> +    """Enum of hashing algorithms."""
> +
> +    DEFAULT =3D "default"
> +    SIMPLE_XOR =3D "simple_xor"
> +    TOEPLITZ =3D "toeplitz"
> +    SYMMETRIC_TOEPLITZ =3D "symmetric_toeplitz"
> +
> +
> +@requires(topology_type=3DTopologyType.one_link)
> +class TestPmdRssHash(TestSuite):
> +    """PMD RSS Hash test suite.
> +
> +    Verifies the redirection table when updating the size.
> +    The suite contains four tests, one for each hash algorithms.
> +    """
> +
> +    def VerifyHashFunction(self, hash_algorithm: HashAlgorithm) -> None:
> +        """Verifies the hash function is supported by the NIC.
> +
> +        Args:
> +            hash_algorithm: The hash algorithm to be tested.
> +        """
> +        is_symmetric =3D hash_algorithm =3D=3D HashAlgorithm.SYMMETRIC_T=
OEPLITZ
> +        # Build flow rule
> +        flow_rule =3D FlowRule(
> +            group_id=3D0,
> +            direction=3D"ingress",
> +            pattern=3D["eth / ipv4 / udp"],
> +            actions=3D[f"rss types ipv4-udp end queues end func
> {str(hash_algorithm).lower()}"],
> +        )
> +
> +        # Run the key update test suite with an asymmetric hash algorith=
m
> +        with TestPmdShell(
> +            rx_queues=3DNUM_QUEUES,
> +            tx_queues=3DNUM_QUEUES,
> +        ) as testpmd:
> +            # Setup testpmd environment for RSS, create RETA table,
> return RETA table and key_size
> +            reta, _ =3D SetupRssEnvironment(self, testpmd, NUM_QUEUES,
> flow_rule)
> +            # Send udp packets and ensure hash corresponds with queue
> +            parsed_output =3D SendTestPackets(self, testpmd, is_symmetri=
c)
> +            VerifyHashQueue(self, reta, parsed_output, is_symmetric)
> +
> +    @func_test
> +    def TestDefaultHashAlgorithm(self) -> None:
> +        """Default hashing algorithm test.
> +
> +        Steps:
> +            Setup RSS environment using the default RSS hashing algorith=
m
> +            and send test packets.
> +        Verify:
> +            Packet hash corresponds to the packet queue.
> +        """
> +        self.VerifyHashFunction(HashAlgorithm.DEFAULT)
> +
> +    @func_test
> +    def TestToeplitzHashAlgorithm(self) -> None:
> +        """Toeplitz hashing algorithm test.
> +
> +        Steps:
> +            Setup RSS environment using the toeplitz RSS hashing
> algorithm and send test packets.
> +        Verify:
> +            Packet hash corresponds to the packet queue.
> +        """
> +        self.VerifyHashFunction(HashAlgorithm.TOEPLITZ)
> +
> +    @func_test
> +    def TestSymmetricToeplitzHashAlgorithm(self) -> None:
> +        """Symmetric toeplitz hashing algorithm test.
> +
> +        Steps:
> +            Setup RSS environment using the symmetric_toeplitz RSS
> hashing algorithm
> +            and send test packets.
> +        Verify:
> +            Packet hash corresponds to the packet queue.
> +        """
> +        self.VerifyHashFunction(HashAlgorithm.SYMMETRIC_TOEPLITZ)
> +
> +    @requires(NicCapability.XOR_SUPPORT)
> +    @func_test
> +    def TestSimpleXorHashAlgorithm(self) -> None:
> +        """Simple xor hashing algorithm test.
> +
> +        Steps:
> +            Setup RSS environment using the simple xor RSS hashing
> algorithm
> +            and send test packets.
> +        Verify:
> +            Packet hash corresponds to the packet queue.
> +        """
> +        self.VerifyHashFunction(HashAlgorithm.SIMPLE_XOR)
> --
> 2.43.0
>
>
The testsuite looks good although the functions need to move to snake style
naming convention.

Tested on an Intel XL710, which skipped all but the default hash algorithm
(passing).

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
Tested-by: Patrick Robb <probb@iol.unh.eu>

--0000000000003ec9ac0632b4bc28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 25,=
 2025 at 10:34=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@a=
rm.com">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">From: Alex Chapman &lt;<a href=3D"mailto:alex.c=
hapman@arm.com" target=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
<br>
Port over the pmd_rss_hash test suite from old DTS. This<br>
suite verifies that the 4 supported types of hashing<br>
algorithm used in Receive Side Scaling (RSS) function<br>
correctly. Them being DEFAULT, TOEPLITZ<br>
SYMMETRIC_TOEPLITZ and SIMPLE_XOR. This test suite also<br>
verifies the supported hashing algorithms reported by<br>
the NIC are correct.<br>
<br>
Signed-off-by: Alex Chapman &lt;<a href=3D"mailto:alex.chapman@arm.com" tar=
get=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
Signed-off-by: Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.com" tar=
get=3D"_blank">thomas.wilks@arm.com</a>&gt;<br>
<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/tests/TestSuite_pmd_rss_hash.py | 118 +++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 118 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_pmd_rss_hash.py<br>
<br>
diff --git a/dts/tests/TestSuite_pmd_rss_hash.py b/dts/tests/TestSuite_pmd_=
rss_hash.py<br>
new file mode 100644<br>
index 0000000000..d21e33456e<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_pmd_rss_hash.py<br>
@@ -0,0 +1,118 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;RSS Hash testing suite.<br>
+<br>
+Hashing algorithms are used in conjunction with a RSS hash keys to hash pa=
ckets.<br>
+This test suite verifies that updating the Hashing algorithms will<br>
+continue to correctly hash packets.<br>
+<br>
+Symmetric_toeplitz_sort hasn&#39;t been included due to it not being suppo=
rted by<br>
+the rss func actions in the flow rule.<br>
+&quot;&quot;&quot;<br>
+<br>
+from framework.remote_session.testpmd_shell import FlowRule, TestPmdShell<=
br>
+from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import NicCapability, requires<br>
+from framework.testbed_model.topology import TopologyType<br>
+from framework.utils import StrEnum<br>
+<br>
+from .pmd_rss_utils import (=C2=A0 # type: ignore[import-untyped]<br>
+=C2=A0 =C2=A0 SendTestPackets,<br>
+=C2=A0 =C2=A0 SetupRssEnvironment,<br>
+=C2=A0 =C2=A0 VerifyHashQueue,<br>
+)<br>
+<br>
+NUM_QUEUES =3D 16<br>
+<br>
+<br>
+class HashAlgorithm(StrEnum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Enum of hashing algorithms.&quot;&quot;&qu=
ot;<br>
+<br>
+=C2=A0 =C2=A0 DEFAULT =3D &quot;default&quot;<br>
+=C2=A0 =C2=A0 SIMPLE_XOR =3D &quot;simple_xor&quot;<br>
+=C2=A0 =C2=A0 TOEPLITZ =3D &quot;toeplitz&quot;<br>
+=C2=A0 =C2=A0 SYMMETRIC_TOEPLITZ =3D &quot;symmetric_toeplitz&quot;<br>
+<br>
+<br>
+@requires(topology_type=3DTopologyType.one_link)<br>
+class TestPmdRssHash(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;PMD RSS Hash test suite.<br>
+<br>
+=C2=A0 =C2=A0 Verifies the redirection table when updating the size.<br>
+=C2=A0 =C2=A0 The suite contains four tests, one for each hash algorithms.=
<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 def VerifyHashFunction(self, hash_algorithm: HashAlgorithm) =
-&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verifies the hash function i=
s supported by the NIC.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_algorithm: The hash algorit=
hm to be tested.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_symmetric =3D hash_algorithm =3D=3D HashAlg=
orithm.SYMMETRIC_TOEPLITZ<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Build flow rule<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule =3D FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;ingress&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;eth / ipv4 / ud=
p&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[f&quot;rss types ipv4=
-udp end queues end func {str(hash_algorithm).lower()}&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Run the key update test suite with an asymme=
tric hash algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_queues=3DNUM_QUEUES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_queues=3DNUM_QUEUES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Setup testpmd environment for =
RSS, create RETA table, return RETA table and key_size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reta, _ =3D SetupRssEnvironment(=
self, testpmd, NUM_QUEUES, flow_rule)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Send udp packets and ensure ha=
sh corresponds with queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parsed_output =3D SendTestPacket=
s(self, testpmd, is_symmetric)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VerifyHashQueue(self, reta, pars=
ed_output, is_symmetric)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def TestDefaultHashAlgorithm(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Default hashing algorithm te=
st.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup RSS environment using the =
default RSS hashing algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and send test packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to the p=
acket queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.VerifyHashFunction(HashAlgorithm.DEFAULT)=
<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def TestToeplitzHashAlgorithm(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Toeplitz hashing algorithm t=
est.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup RSS environment using the =
toeplitz RSS hashing algorithm and send test packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to the p=
acket queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.VerifyHashFunction(HashAlgorithm.TOEPLITZ=
)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def TestSymmetricToeplitzHashAlgorithm(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Symmetric toeplitz hashing a=
lgorithm test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup RSS environment using the =
symmetric_toeplitz RSS hashing algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and send test packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to the p=
acket queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.VerifyHashFunction(HashAlgorithm.SYMMETRI=
C_TOEPLITZ)<br>
+<br>
+=C2=A0 =C2=A0 @requires(NicCapability.XOR_SUPPORT)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def TestSimpleXorHashAlgorithm(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Simple xor hashing algorithm=
 test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup RSS environment using the =
simple xor RSS hashing algorithm<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and send test packets.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to the p=
acket queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.VerifyHashFunction(HashAlgorithm.SIMPLE_X=
OR)<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>The testsuite looks good although the =
functions need to move to snake style naming convention.</div><div><br></di=
v><div>Tested on an Intel XL710, which skipped all but the default hash alg=
orithm (passing).</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a=
 href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div><div>Test=
ed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.eu">probb@iol.unh.e=
u</a>&gt;=C2=A0</div></div></div>

--0000000000003ec9ac0632b4bc28--
