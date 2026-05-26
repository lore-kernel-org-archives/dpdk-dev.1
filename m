Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5FDCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 18:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0500F40659;
	Tue, 26 May 2026 20:12:12 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 585E540649
 for <dev@dpdk.org>; Tue, 26 May 2026 20:12:11 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso4977910b3a.0
 for <dev@dpdk.org>; Tue, 26 May 2026 11:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779819130; x=1780423930; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyV0nH05RGPl2fM8dxMqz/uRnq+QPFovDw/+MYz+34k=;
 b=XCm1bV9lIDEEndWIWOijmplDlZ74p4KE/dQ9IU8zgHsDIOiMZSPItXhDhrUeOkotp5
 78tNE5osKIx9CY2bHwmKhgfeXaEEJbiXcZnoMagM8ExbeVdjj28oYsmtmgvu94axp7SQ
 1Y4Rjw6BPQZ0SI5Bgz12ogsc1a9tfEQVylOjHCmz5/97pa2hLE0yeREP5QeOB+1ye1NV
 5YT2O7SAxmoxR1GhxeWrdVCoLYdk75IQqFc9rbOxpu0FAbI1DaonZBjs6IZWdByyGd5/
 8TNDTVGZqbwazsV056F5aolnSWUN6OTS13/NQgvTXRtJfkGbkytUUK9nfiolK+eLDnHW
 e86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779819130; x=1780423930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EyV0nH05RGPl2fM8dxMqz/uRnq+QPFovDw/+MYz+34k=;
 b=cT65i5Y9YT6nS4A89wunBpgMnYMm+jhwCpXRaBG2MxeIcQozysEJPS2zTk58iH3/66
 AglI37pGnsHZaixqbBahjc/4sACE2bmtOcbmRY98WQACyuPl7CjUpd9Z//lEAK+E+9k0
 R9FJU071k4Wpjw22380XXUNy+9/WUgHXwvTHjACJmmZQ6iLHrJpDIUanaq4EwRSfD4A8
 UslwKzhm3FmSH83tc0M9kuANrZa6KCikk1xcAa1IXQ8TBryYyq/9tZZs/Y1sy3sku4yK
 ziGttwP4D1WLmjgSIj28yovRYS+0UAma8v71irwPMu09rMmTtmqnm2uB2RYgK7I2ZyX/
 KtoA==
X-Gm-Message-State: AOJu0Yx0Gn6nk6CMLc9XeExYmz5kX52iafIv4kAp6olUb5qkWFhrxsLK
 Nwt1hF8SFHA4iKQhidZeKU/5rf4NipTwAGwKbL49+Gi9khNynLXZs69f
X-Gm-Gg: Acq92OESnjAXjDKaciTqD7FepNRr94ATsTARWiCxNAm5Bwnki5pMz+mfLzSu3OKbU0h
 2J0vCumxjY1VVum0xQjInGUUhYWFjdL5P1vDoIzlAL5lk20kza3jR1mdE+zBtNUYMcUHoJsnU8D
 P5rmocTp5HIt1ddk6Mr0cS8YO57oRnHbQft9CpAWIr7yiP4XObE45p5V2mGwTcob8bXsfo3CVl6
 wimpqEmBSmpL2otM8V0AjFJW/bH0SodDpUGWo4UQcDt98AQBildsoA5CKmFEWlcoqmlVSYRFGXO
 aXDGnBoOoaMeeA8TQICgi4VkL5wZ1IOJzrjiw4uBqv2SDF+lbpKCVdvaeiEKbEjOVeqcK53kbEI
 yDcxh83V7WaPUOcWoH1+84V/OpqnfAJ2vImXVHVmH+0EBotvIfbNixbZJIwQgmY8guqdGgo+oH0
 wwi94g42CLTtwEP1M2gt40NatwZEsjRf4=
X-Received: by 2002:a05:6a00:908b:b0:83d:446c:2a8c with SMTP id
 d2e1a72fcca58-8415f406c9amr19274968b3a.25.1779819130459; 
 Tue, 26 May 2026 11:12:10 -0700 (PDT)
Received: from JRT-PC.. ([119.234.49.191]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7a5sm16741462b3a.33.2026.05.26.11.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:12:09 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: orika@nvidia.com,
	thomas@monjalon.net,
	andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 James Raphael Tiovalen <jamestiotio@gmail.com>
Subject: [PATCH 1/2] ethdev: fix out-of-bounds write in GENEVE option
 conversion
Date: Wed, 27 May 2026 02:11:58 +0800
Message-ID: <20260526181159.287633-2-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526181159.287633-1-jamestiotio@gmail.com>
References: <20260526181159.287633-1-jamestiotio@gmail.com>
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

rte_flow_conv_item_spec() is documented to truncate output to the
caller-supplied buffer size. For RTE_FLOW_ITEM_TYPE_GENEVE_OPT, the
deep-copy of the variable-length option data was gated on `size > 0`
instead of `size >= off + tmp`, the form used by the sibling RAW
branch. A caller passing a buffer just large enough for the header
struct had adjacent memory clobbered by up to `option_len * 4` bytes of
option payload.

Align the GENEVE_OPT guard with the RAW one.

Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
Cc: stable@dpdk.org

Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 lib/ethdev/rte_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
index fe8f43caff..63b686ddfb 100644
--- a/lib/ethdev/rte_flow.c
+++ b/lib/ethdev/rte_flow.c
@@ -697,7 +697,7 @@ rte_flow_conv_item_spec(void *buf, const size_t size,
 		src.geneve_opt = data;
 		dst.geneve_opt = buf;
 		tmp = spec.geneve_opt->option_len << 2;
-		if (size > 0 && src.geneve_opt->data) {
+		if (size >= off + tmp && src.geneve_opt->data) {
 			deep_src = (void *)((uintptr_t)(dst.geneve_opt + 1));
 			dst.geneve_opt->data = rte_memcpy(deep_src,
 							  src.geneve_opt->data,
-- 
2.43.0

