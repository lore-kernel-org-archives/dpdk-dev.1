Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85681CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4648F4025E;
	Wed, 24 Jun 2026 13:47:39 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id EC175400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 13:47:36 +0200 (CEST)
X-QQ-mid: Yeas8t1782301650t342t15798
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 4911648651565492015
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-8-zaiyuwang@trustnetic.com>
 <20260623095047.7d12d5d4@phoenix.local>
In-Reply-To: <20260623095047.7d12d5d4@phoenix.local>
Subject: RE: [PATCH v9 07/21] net/txgbe: fix Tx desc free logic
Date: Wed, 24 Jun 2026 19:47:28 +0800
Message-ID: <002001dd03cf$3c271210$b4753630$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwHXiZW4AdwdvwYCkVl8PLVvLKXQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MRUyyTndl9c1Isuq7O4KCLL5UVLIWUg7ONWMMLVIKbOM5zdpGwLpoR3R
 NR7I93F2a+WMbX96s8qZkaTG+dEi4vA1DTIw8nthx3Vl8dhRQ51eCoL5JuzmguacJs9BB4p
 3sjO3QSjkU/vpIucnIBiXqiNg3f1lskcZ42sd1ENoRgTp9w5bA5nme7OMdWtqMcbNgfQPdb
 8R5wJhnJ8z0FZ0nLSLHBpVAstXR04WiNqUjO8w6FtpGY0aeiX298YeBvl5LIWs6FuDearOF
 22m+ai4tNi7yP4kwFLCIAfTdk2F8dCIUPKXPoC9RMiAd58VKSHV0nio0FEEUjWcSIHZ8+qK
 xZdgf0PiWMUr/w/qmzDx8kWSzUJNoDRSsluxsdEF7FuUKwE0n4Zk6fdpDXqjoenqNcvp5LS
 uSVHFligFNeOO+Kt6+RjaAGFtM9DmUX0duQ4MchKHtNavwNPjfksUr2PHwYVso+xP4Jw1bA
 VfNDnC4XeQopJX9o5kyrKkOBIigwTzk6uiWXt22hdyLymDyHsUOnjhVDvLDfQ4Q+HCgqLOe
 lvZjfjSMJApFuOYMiDTefP/vSPIIPiwTKG+TbX/78ya1EyRM7A3U0SbpObi45nRs7su4SnY
 KI89kLQk5hLsu6npMwWbCPlrEKpUmtx07i/E8vkwlrDxVhJwrceI0jk/dpq7hbyutrv6VYb
 v4XFR5aBSWrklZnJ+uW1TmBQDhjW/3k5wcZCG3zSrc6KtiZwrePdOre5L14hqBibcNsuvKe
 sK0KpXoZcvgsiFCGJNHEOxhakZ2rFhVHN2Wy2Nr3PjoLjqbNryOE86n4qYQueKbrq7I8kNa
 hZeJJE45zvsUtdhQeaZ/p02Tg7Y6cQG5iOJVs2zWxp2OUWsGqBMBw06kI6osfQ90aEGddBG
 JsINrcp/roOvHrhJRBIkp7Hlj14EUbv3lRXjBHTPjeLo0KFBm5hT8/J+ysEenBnPq9iZe3n
 JOBbbjtw8xVb59JSWOgkuAxamcy9gy4cu2MWG0HrHnqBLKTvWqI7MZl5aOHbDH6QpvgNiU+
 mra+HJSZ4IDodbbeJRGWhoz39WbuHVW8Kjgx7/DVhABuybq/wI5MXe3D2XUBo=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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


> This will fail build on clang since txq->headwb_mem is declared as volatile not _Atomic
type.
> 
> Please fix, and resubmit both patch series.

Hi Stephen,

Thank you for pointing this out. I apologize for the oversight - I failed to pay proper
attention to the failure from ci/github-robot: build, and mistakenly focused only on the
ci/Intel-compilation and others.

This error has been fixed in v10. Additionally, the unprefixed symbols that did not meet
the naming conventions have been renamed with the txgbe_ prefix.

Our other patch series will be resubmitted later. The code for VF sensing PF down differs
from our OOT driver, and its functionality requires further validation before submission.
 

