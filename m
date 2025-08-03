Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299CC87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 17:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1999F4026C;
	Sun,  3 Aug 2025 19:24:13 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 6D85B400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 19:24:12 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45617887276so13728945e9.2
 for <dev@dpdk.org>; Sun, 03 Aug 2025 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754241852;
 x=1754846652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpTPS7oca0TOqkSXiEhirJpQubgEvwqgZpKkTtjck/M=;
 b=J1zTnnXGFfZvsBF3GsuGStot/bK/1/zRxhCyjxd4lDbnazYV86xizlEw6+QIW1I3n5
 Ooh9635dy7K9jaueiRoudqneymE9So33z3o+oCcaHFd04IewldADY2nTZJhTjC4bZzUz
 LRbH0iWF17hdxIFtm/g5quzISNGJg4lyV++5pTJHhTzgz1iBM8Z8FJDW7P3B7/4sb11X
 i41rNnAIFwKwhvYXBu6RGoYDX7pN7McPQpdOUhc8K0legp34ER24fHwandiH/qA+yNcf
 cSqCjy/MYj418qQxlDDdQceM1/V3kBaY09oiKNyZizDXpZVpWxKKYPZ5c3vvbToxpmkj
 5bFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754241852; x=1754846652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpTPS7oca0TOqkSXiEhirJpQubgEvwqgZpKkTtjck/M=;
 b=d0Rm3o9ow07lbtBfFvZYod7Bilc+H/gcDgH7+eO2sUQE48S2KKJEQyXJleGcRqnxXg
 S1SAUvGfEG4J8XvxjhJcweFCGgAqhEXvVibjnfrIWfMvHd1EWyUtGtq7JFmvRx+ZOywa
 uhy1zmZ6j+dg1zGEWRrlP4Y/0f+czP4yzp4EjCg1Mb5xIkhUh1M/5U7A4sRhq/hfBjA9
 VjguYUgge50a/nBaNlqF4kRf21sXsrSMbx89adppek5HUvnaT78iehakQlg5cELmoje8
 OYOg+/CQgxeRD7Mgir4c3FBRn6O7fn5bF+7ybUUS6mxGx3jPtN73QB2XWfxzO+2l25ys
 uNzw==
X-Gm-Message-State: AOJu0YyqqhMoeGxELhMM0ur1tE6sMJ7sS0DXzasisYmvB2IdgIqK3chJ
 SKcSFiE/yQnNyin48HuH4lkTTQGxdu3EcICa6mOZV68ySDv1Wyj7Fa4sBAryaqvrXSk=
X-Gm-Gg: ASbGncu/3Zsr/YTPExnPqGc4vyFMYG/MoucuV1lJFn0tklbMUFX9gUUEHnUguQHGwfk
 1ps3xfwPoWEPeq0zwn0edTR8ppGYWKNS4LDeWrmXSq+8xvstytVFBfUAPoRB0EVFbsuR8lYkOCO
 cai+BIRlTTzrozfvmMjo1BTbjbJ8W8qyzpB+G49cmH8y1JeTlssIYqy3rqL+YzlUOQzKRs7cv8G
 FYIMj0JyIUadeLgvI0dUnU1r98E08pRHKYhOeVuJAohWUFr86S0iiroRT9+KWbpOj20lpzKwwn3
 5hxEF76ugA1E1Q7K3iAf9KAPCojlSQB1KImOW2+0satpeCaJFAuFWFjdT0oYi4f5B81S4C5zNlo
 2VkjJPMrfsCgV9Hm0tRCckMIxkJMwkwEQDPKXWdRUutz9iRXZ5h28R/P2Ky7lav4lxtH5c82I/Y
 0ljQeY3IYpmA==
X-Google-Smtp-Source: AGHT+IHxQv4hTL9BqROfRiypYnUmKfAuEeV+uqWLit03wyY/6cMtySWC7VhsHPkzsnku3LfXjsTsZA==
X-Received: by 2002:a05:600c:3b23:b0:455:f6cd:8703 with SMTP id
 5b1f17b1804b1-458b6b5bee8mr66112795e9.31.1754241851944; 
 Sun, 03 Aug 2025 10:24:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0bfc79fsm2686340f8f.56.2025.08.03.10.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 10:24:11 -0700 (PDT)
Date: Sun, 3 Aug 2025 10:24:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: Re: [V5 13/18] net/hinic3: add dev ops
Message-ID: <20250803102405.145521bc@hermes.local>
In-Reply-To: <20250702020953.599-14-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250702020953.599-1-wff_light@vip.163.com>
 <20250702020953.599-14-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  2 Jul 2025 10:09:36 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> Add ops related function codes.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> Signed-off-by: Xin Wang <wangxin679@h-partners.com>
> Reviewed-by: Yi Chen <chenyi221@huawei.com>
> ---

Some spelling errors in this patch that should be fixed.

### [PATCH] net/hinic3: add dev ops

WARNING:TYPO_SPELLING: 'resourece' may be misspelled - perhaps 'resource'?
#1893: FILE: drivers/net/hinic3/hinic3_ethdev.c:1897:
+ * and free io resourece.
                ^^^^^^^^^

WARNING:TYPO_SPELLING: 'coverting' may be misspelled - perhaps 'converting'?
#3906: FILE: drivers/net/hinic3/hinic3_nic_io.h:100:
+	/* Hardware will do endianness coverting. */
 	                               ^^^^^^^^^

WARNING:TYPO_SPELLING: 'indrect' may be misspelled - perhaps 'indirect'?
#4431: FILE: drivers/net/hinic3/hinic3_rx.c:450:
+			"Set indrect table failed, eth_dev:%s, queue_idx:%d",
 			     ^^^^^^^

WARNING:TYPO_SPELLING: 'Does't' may be misspelled - perhaps 'Doesn't'?
#4474: FILE: drivers/net/hinic3/hinic3_rx.c:493:
+		PMD_DRV_LOG(ERR, "Does't support rss hash type: %" PRIu64,
 		                  ^^^^^^

WARNING:TYPO_SPELLING: 'possition' may be misspelled - perhaps 'position'?
#4522: FILE: drivers/net/hinic3/hinic3_rx.c:541:
+ * Search given queue array to find possition of given id.
                                     ^^^^^^^^^

WARNING:TYPO_SPELLING: 'pakcet' may be misspelled - perhaps 'packet'?
#4708: FILE: drivers/net/hinic3/hinic3_rx.c:727:
+	 * If RSS is disable, no mbuf in rq, pakcet will be dropped.
 	                                     ^^^^^^

WARNING:TYPO_SPELLING: 'indrect' may be misspelled - perhaps 'indirect'?
#4775: FILE: drivers/net/hinic3/hinic3_rx.c:794:
+				    "Refill rq to indrect table failed, "
 				                  ^^^^^^^

