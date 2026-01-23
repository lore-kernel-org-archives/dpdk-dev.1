Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC6D74EFA
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F65C40395;
	Fri, 23 Jan 2026 17:27:57 +0100 (CET)
Received: from mail-ed1-f97.google.com (mail-ed1-f97.google.com
 [209.85.208.97]) by mails.dpdk.org (Postfix) with ESMTP id 34381402F0
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:27:56 +0100 (CET)
Received: by mail-ed1-f97.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so3691961a12.1
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1769185676; x=1769790476; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6h0S+mam9jxvx+/K2ZPqZJvY05LAcy1Pb5rmDO4aNls=;
 b=JndVOQoiM1YjIkYrrbsd6PQY5NMwk6DuYiRXgRNN5IichoTJzdqqgOiVag+beSaAAA
 erA/ztLe2qSkZs3miz7XoSFP/kOYnLZofF3BeBVIofCBTuo9WWzf0ZHcydoaPWgUN7c4
 D9qctuOPbyzB72F2K5tbTh3NizgTKyulPMiWVYcQ52kl5en0ezOj/LbCyuK6dF7F7zkG
 8RERDqVIwUj/7XhI+jk/45kJKFyB3acZa96DisJasts18e69SUOf1IQZPGdpOZHf86OT
 g8YzPwCo30tYldM2M+rit0pmszfrmWBZjk4PxAxt0AQ4FP8FW71CL5sQvtbU8qpvnXo2
 mECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769185676; x=1769790476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6h0S+mam9jxvx+/K2ZPqZJvY05LAcy1Pb5rmDO4aNls=;
 b=gBRpGN/q8BbFGiohlhB8vewkhwdLGYdeuGrWkVbQqOSySq0I5oNO8iHbRIvOykR34e
 I2GD1kQZJSJzritmwSEtMZEBEONsh44UsLDzQ3LiABGd+kzsfIDytWCkCseT10WO4r5Q
 8D/IHj6brBwlyNyagBgaz4ULjuaUa6diCAqiUA3CJB8td6GOkEfvLL2hH/WfacK60nlZ
 2eYcvdvKpmH1RgreWIG1uCJbfCasP1Ht1Vq/nz9GGSxoI93nmwQ+i3YGDVL21MajgkmC
 J8EX0HLVMkR0+2e3SRQ9MypZUT1JJmVAsDQlmL9s+cNRYr44H8V0xJIEcIjJv5AysLYO
 1MIA==
X-Gm-Message-State: AOJu0YyilVhbhi6ft45REagbTFQFwVkSCpXuVolpVlyJP7KY4pUrKn6X
 hVLWgSKtEO0U+uvAwXsWwn6ivS3gJ6vKWT0Trb0AgUpYNytVu6SbI1HhRSsQu1B4EanyV8xnGE8
 E7L8WKFn1UhjAhhnlRQRPO0mQAxak895qVo4WwoYS51Q=
X-Gm-Gg: AZuq6aJu/iuJrcM9G9Ajziip+kb3WNDEPr/bmMSaWEExMYn75y0S9wGliCDYnWEgyaP
 Y5Z13O/5EDONmKtwCrIBscnNFOxsfR4fV3xwqUc/c4+r0q5ebYEHloTM5lKhBabhjy4iUMgv4A4
 3ok7R7Iwxs7K32JBqoAKU3kwXJV05xI0GQIgQlbby6p7EXb6H+c8FLtdXBVyl4LWRA8rCRQC9OS
 t+XMe3M46uymfrlxwkFPK4P2JbGNTEVLpktn636hJf97Cawbc3QfDAynWauMIoUKLeHuTQfUpru
 +GWLKdInZM1WncnE5/z9KzlmrAsEmQqF5O3kyjPv4tSH1r/oGX3JZa1p9WzlKnGsWGyuIZ5uRG9
 acT0CPRq1vkHMFTCCydvgVGbXRNX6tOWtMnuB0P7hDHUgqcaMlL10MU8uq2M/8Mms
X-Received: by 2002:a17:906:2083:b0:b88:5b35:914a with SMTP id
 a640c23a62f3a-b885b359bbdmr207305866b.57.1769185675735; 
 Fri, 23 Jan 2026 08:27:55 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-b885b64bf7fsm33171966b.46.2026.01.23.08.27.55; 
 Fri, 23 Jan 2026 08:27:55 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (vader.dev.6wind.com [10.17.1.39])
 by smtpservice.6wind.com (Postfix) with ESMTP id 8D5F7242A3;
 Fri, 23 Jan 2026 17:27:55 +0100 (CET)
From: Thierry Herbelot <thierry.herbelot@6wind.com>
To: dev@dpdk.org
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org,
 Olivier Matz <olivier.matz@6wind.com>
Subject: [V2] drivers/net: reorder Intel drivers list in meson script
Date: Fri, 23 Jan 2026 17:27:07 +0100
Message-Id: <20260123162707.1854505-1-thierry.herbelot@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
References: <20260123162104.1854187-1-thierry.herbelot@6wind.com>
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

After an upstream patch (see Fixes), net_ixgbe_vf is no longer
declared in testpmd PMD info, when compiling under Redhat-9:

> $ meson setup build && ninja -C build
> $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>     "name": "net_ixgbe",

Name 'net_ixgbe_vf' should also be reported.

One workaround is to move 'intel/ixgbe' as last in the list of Intel
drivers. This restores net_ixgbe_vf under Redhat-9:

> $ meson setup build && ninja -C build
> $ ./usertools/dpdk-pmdinfo.py build/app/dpdk-testpmd|grep ixgbe
>     "name": "net_ixgbe_vf",
>     "name": "net_ixgbe",

Fixes: 04f1b16c54f3 ("drivers: merge common and net idpf drivers")
Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>
---
V2: use shorter lines in commit log.
---
 drivers/net/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index c7dae4ad273c..8d96244cdbb0 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -32,8 +32,8 @@ drivers = [
         'intel/ice',
         'intel/idpf',
         'intel/ipn3ke',
-        'intel/ixgbe',
         'intel/cpfl',  # depends on idpf, so must come after it
+        'intel/ixgbe',
         'ionic',
         'mana',
         'memif',
-- 
2.39.2

