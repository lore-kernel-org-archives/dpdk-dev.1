Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D835BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B66640287;
	Thu, 18 Jun 2026 16:25:38 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 16F3040268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:25:36 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9DA2114000E2;
 Thu, 18 Jun 2026 10:25:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 18 Jun 2026 10:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1781792735; x=1781879135; bh=wRgJp/z4O29yKvAtxN1CS
 khNQT7oTiKEhmtGWCVc38E=; b=Uc+mDnBJie1Y8vbHw572JyeZfMazWwhAgidud
 c3WyQXsDw3TJKkgNdbi43LOHi+gIe/dPrSuJ9T4zPFpIB72UsiCkwAirpFKrW9Yx
 nlZat1k4DbDRMmOhW9pMUOdFuyTE/BWW/rj9LsVOVJ8L7PjTdlK0YWdFrQMURHwM
 o4BQFuJxeF9MbRutXWDDQlNpinWQplSNmzbdd9XrIoUHL0lCeVMMCHexoQpdUhN8
 b6Z8ZO3YfeLg0IB/sVFkunuuSDI5U1hK4F61TD5zAeNn2SSMLzCYNRJtGJqGiley
 Ju27wrJHS981ox232NZlSajCGuNY/sf/3QshK7FhEMI9rgXsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781792735; x=1781879135; bh=wRgJp/z4O29yKvAtxN1CSkhNQT7oTiKEhmt
 GWCVc38E=; b=N8ck/zM+FwcxSuqtO2t4v+kKZ5sMcMAzhiAgw8spLqxiBcPREpX
 UHoSuTzSKjXxLRHQqzJCJsT2VUnil1jSyQfjqwUZ/GJomHZKeibMnVcUg1AWTIt8
 mjw6l1uTCnrpkt2b52Fv6CdaJyfY4Du6/8+GaA01mTIe4W5J1i2vCvpNdJmzzL1l
 2RVFnX8/KbHjWPjolG1Zesez6nP3769c+yEovamnb75nXzlkP2CYWNlaHJrm8FpZ
 DxBhub8RfWByZk0222yNtvMixwLcfI/GI9ue2lAKELGAVhmx6X3Wj7LKChrKNVPP
 MQKXvARIwLbaBRGEITpE6FH7uyiaJs5fCkw==
X-ME-Sender: <xms:3_8zakgo9w_yPu5c85-s_Ce1E2UbBU05B5zSrvFKjvZIgQ3_l6UtgA>
 <xme:3_8zapXDdy4ZwcQ4bPIxz_3v4bMcoy6GsqVfYnOYNX2ps45BzpR38H5pBjRR2GOn0
 kLWpn_V5y6Y0cBsv8NEt9aiu2_zzZVtOlEiqJhD89TTa4EHlhLu>
X-ME-Received: <xmr:3_8zau0tEfVplhVX9AnbFPjhlEJ6oMJ1OfcQpdmY5YBCp3vgf0r09Pfx6GuvTs4cXISpl8qpvO1Dl361c5H7yV5oxaBmUKo>
X-ME-Proxy-Cause: dmFkZTEzv7wHv5H7EYkDu2gXqE4wFNhPnLDfKXxDcblIAzBFGRU8fdOGsmcJxHEwYoiuyK
 SzwJLT0tiU6WoFwk24MxNBqV2Wv3DjXyjcP6YP0p/9UreeXingrRzbpqiBdxqnSIQ772c1
 ofidNhGYaatxegxYWEd6w1P3wdxkBmyrI/nEBiVc18R12hWHL0zxQeTpj5hySGh5I9o6v5
 bbRFuJ3A6ZXtQe9EkfWE/6AScD4jWddbF2krBczj6a4N2p0LXTLnFlA/DCssg2AeuSzZ9u
 oWrvxJuFbukwGrLdCMSx8zF4Q0n7jmCXe/exykDz3YywAWDZhBSocLRlIYUZYGunX/THKL
 o/oP6wEyhElPTqFxdID8fUcRWSJs/dWXlgTf2RsQ7ovWIJRqAN/f0KhC2v6538SxYXt4S2
 GPCT6MvJJ9/nq/jZtdi75U8YbIvjQ6qF/PETzquN/oAgzwGtDmy+QQLD+QidxHzQbNx3JF
 Tuh+SVFz93VR/87UjpvlL3PGF40apdEDACPZYzgMj6GlNEdLXR0XOW5mU272UH+wy870J8
 ZE14I4alfMhkU1ofJLsnW48JZ1oAUY1Vz/ElRCwzVGtHJ6WYqQZTWeDHWp3wpQSbBWz+PV
 q/j0Biz4bEQcVMdnIDsaIHQC8ZRdcqs8KvhiaqWtD77ZI4wcl2UwMrYavQQA
X-ME-Proxy: <xmx:3_8zanEbo3zed5gEyO188M29YbavbbgEJ2Fyfas0O2LdJ_0PYJLD-g>
 <xmx:3_8zakgrjxp5RqRfp1y8Q6ha2MZZGCJ0MWiUD4k9eye6zKNt-KfYFw>
 <xmx:3_8zaq9mEm7AoD9aZD4AKWR9r5DWNrnEndWvzjmnExJJvlP1qEEtNQ>
 <xmx:3_8zajpwMbuZcQUiRwogweaNARkQNJKHpTvsAzKMb7juFBd6dabBMA>
 <xmx:3_8zapI9ZO5cWlFcuckNsobE1fyMTHPgIDMWfEmk6Vw8XR51UDRL5q2E>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 10:25:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH] examples/ptp_tap_relay_sw: forbid shadowed variables
Date: Thu, 18 Jun 2026 16:25:26 +0200
Message-ID: <20260618142526.191340-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

By removing the compilation flag no_shadow_cflag,
it becomes forbidden to shadow a variable.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 examples/ptp_tap_relay_sw/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/ptp_tap_relay_sw/meson.build b/examples/ptp_tap_relay_sw/meson.build
index e78b284ad8..f9fb6780f7 100644
--- a/examples/ptp_tap_relay_sw/meson.build
+++ b/examples/ptp_tap_relay_sw/meson.build
@@ -10,4 +10,3 @@ sources = files(
         'ptp_tap_relay_sw.c',
 )
 deps += ['net']
-cflags += no_shadow_cflag
-- 
2.54.0

