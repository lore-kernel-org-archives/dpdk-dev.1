Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3274606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=kTayGLw+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=J9wsHqCo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 276404060A;
	Tue, 20 Oct 2026 11:51:39 +0200 (CEST)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTP id 2442640144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:51:37 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 815FD7A0140
 for <dev@dpdk.org>; Tue, 20 Oct 2026 05:51:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 20 Oct 2026 05:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1792489896; x=1792576296; bh=nnntIICM1XB1X5V+xmfqb
 1O8hyOtiKfHw2ICnXwUHXw=; b=kTayGLw+7JMX86kXnUMZYmNvx0Gy1POe+sbw/
 U2Maxx9uC1Niwb0SsfTsTz3tMSD81/0UB9Nc08A5C78Qw3DgrT9mZx2P4gj1/Ff2
 gZbrAwjSPcW3/Nd1yMB2bzBzOOA4LXGydvHPSce2D3/ULDTIM71Tg3pNB6lUIkqN
 f/TCMoJvUsarUP00DJYPHJZxk3poc1kHmCCr6uo64mozlTpaYqwo5L06UAe9nQuk
 Ohrxt0sFpj0tEyLGIqYE1W5KiLN1GBHNaK7eWfMo+wFinUin5tVviPobQpZsZlHF
 ie9u2/A5LhJxPQmmqJwbLxX+c+X0KXtB9cW4lOlL9JMIPqg9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792489896; x=1792576296; bh=nnntIICM1XB1X5V+xmfqb1O8hyOtiKfHw2I
 CnXwUHXw=; b=J9wsHqCoWKGkaz8TWN16lbwItpWQt6jk066zjczqLeXKrCM36Hp
 oArtf1yH2bNDK3XKa1pzrSpm3LPyCiYljW0Ov78LCq/w7M+ZwTMmcqSyCtmwSOIG
 hzjVcGXcisNeShxpLwsa1T6DhCT7MsDglkb0c2qt8cqZWBoeMNstOrTDXIzvA8BO
 BuC50SZqjwuzYCV7/X7IRIInUBKf+03x+f+rG4VPZvYE2YqVAURLeKAwViR+nsyU
 BlQNU8fvPpz+uZhOtproYGxKup4A6T1gzD7//mAb5NLeCf1da4f6Elng0f/J+PP2
 jnAov4dOWsK9+JmWCNLRJNe0Z+hYGPue0JA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792489896; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:fLC8+b2pJ3j7C6ZLeJo5jg1CQLtRACTByUYuLca/6t/RtF3
 5Xrg6/6deVywpXiOe653YCmuVMPHsKgeGSUKolnSJKAgWwyS7HpB/SzKunCn17AC
 b3PYn7l9UAoVYkdl8dNYimqU4e4PenWd8CKMZ4YUQZnEnZx53NjMisyrh4TsKxVv
 1LA3PfMuGaR7j9p9s/4IAQauhk3O+4A1iX2qJ5QDlLWeOCgXCFKAodwVqT/LI9Fj
 MXDywpZf4wdFDGqnpodwnN91ZxR5nyp79Xt7oyY4L6NvkXBIiUAISzRKUYVARTfE
 tbUwAJciujCj/UmtuslrvCB+cfvc+SH9aB11Xmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=8;
 hn=content-transfer-encoding,date,feedback-id,from,message-id,
 mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:6HHoILV5X+yrypJOE48poraNkipHPBduLQeElA2jmRc=:mEWOc2pFX45jr8DxlKgwTlcpCW5XvGqkWl1P/uedCbE=;
X-ME-Sender: <xms:qDnXalEDZkBY_ucsw6KmPorTbUOuWpBig11XwDYGImeKX__w5ygbAw>
 <xme:qDnXagPBs9FTqqzFGebOyoihXfjqIc1wiPE-i2TqA9pvPyXPV-6rYAe8QCI_YSZIy
 LEnPDDsQ9hOCGYP-JS6Z0FIfwCCiv1BYYeZbOBb7JzwXWF4suYxvN8>
X-ME-Received: <xmr:qDnXaiOtZlqKuWVfMDuo0HFJN7zvrdcWmVkVWyIULc3uhhXfmUSuFKG4idhjp3Yi8lTuYJCKq5-biLqo-vCrgvIe2m-l>
X-ME-Proxy-Cause: dmFkZTEy1+zqq5/Fv4BO+NssVDusb/QBLutGrzc1FoB6cMjMjnybQ86+ftLHO1TjIRFmqX
 qF8MQo4aqd6K7MIMplU2DH055f7vsBM4DEDQHIdzMlk6Sq0PT7I4Pp7PKWzjrCgz2+8Rt6
 kXQjynhAp21bUWKjAfM9e8qdbD26geW4chyl3w5Ht3vDbzCFVQvQY7lFXPLWy1K+uZcagP
 24jP2iq45uJGjXCiweMaZvAMf5THNmSlszd6STyihIaZp/vP/0SgNPXgJpVQDmmRs2lADm
 iVOX5UkfeWVqs3VpmknvPugDbNm5J97hASFKCqg/KJsObNzgU5TNZxtVXkEiZMzVm5krbO
 0PM9NetD0jtrSYV1R1ki9gjHO+QurAp1mdcpVwwa791YupZLrNj6qWaU8PPZLuyYzOTR1T
 XA+OH+xR2RvpMotxi9W8GJyp2QZop89MSsO+M/8TAg5hr7OpLkNDVCJYZEpedVjQb5IzNE
 DNk3MAoGzRQkwnQXe7b54cLB21XiLR6/zyDMwaYtdPs17ypuUageq5aNd8fHEwZYGODPGt
 8cxFx+uU3jx8s/NUDiea7kI/yxIIWJQsDbbOBASlhjgpxdp4lGG3eDAqfexuYEktHPIqSY
 hw8sUQmsPatDnLJaQPwsp5QHEtBTJgF8zPHn77K7NiqwgP0yu+/zCO3QqbQQ
X-ME-Proxy: <xmx:qDnXan4-KVpfCeWs_FSC41v8GNisEI6ScGv_2KZPoIxhiol4QZtMtg>
 <xmx:qDnXau46_82IC8ypr4f-CtFWPCnkWo7lheyvhnIMSNu4v3EbT4pyvQ>
 <xmx:qDnXan1seyRP4gdrqmOcnT8AA2ZNWu70XKwXWu5HB1el6E-QnQPOjg>
 <xmx:qDnXaqV0ZnbRWfc_2r2Zz3Uargm0pu2-b19QWN1LmDo90CkCYkIS5g>
 <xmx:qDnXaiEILuJBcA8MrleyQxxqMfXFaK4pMDTkyttOKUGZsTwzoP2MMMqz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Tue, 20 Oct 2026 05:51:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH] maintainers: update for next-net-brcm tree
Date: Tue, 20 Oct 2026 11:51:20 +0200
Message-ID: <20261020095133.2811576-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kishore is the maintainer of the Broadcom tree
since DPDK 26.07 cycle.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93ad53027d..1720cff62e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -32,7 +32,7 @@ M: Stephen Hemminger <stephen@networkplumber.org>
 T: git://dpdk.org/next/dpdk-next-net
 
 Next-net-brcm Tree
-M: Ajit Khaparde <ajit.khaparde@broadcom.com>
+M: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
 T: git://dpdk.org/next/dpdk-next-net-brcm
 
 Next-net-intel Tree
-- 
2.55.0

