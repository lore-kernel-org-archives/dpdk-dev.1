Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E4C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 16:26:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD3EB402A7;
	Sun, 12 Jul 2026 18:26:27 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 8D2AF4013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 18:26:26 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E348F140004E;
 Sun, 12 Jul 2026 12:26:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783873585;
 x=1783959985; bh=em30SwwdrHlyLKjdzvJwFGxqsr1vcfE/w8JSAmSrByY=; b=
 S/uvujR08rp+48ga9kByV3NsctxKKBkpKHDv71EwwlUbN5FQc9DGzWU+XA8x6k+p
 eRb0A+ADb1g9j1i9jQR9FTlg4CPbrO3qcGB174Um+qLMxrdnGfaxdWIlqAp2SKL/
 kSfKhLBFPiH4YQZqFxs6fjFgzJrVEucDepM4HeoW0wW8n62i8WKum0OuvPZQz9Zz
 n8r7B8guGZ75YvL2AXyE+KMuBdBfyj13XDC/v1nulEVlxnA3hAQPIJP5sTPv3MwB
 rpDBhHbLCgdUzXf7nmb9/nndUrxKXgoW5Uf0aeeiZs3Pwkue/+ssd/9WxFu9aFoh
 T22xJq0fY6H+0iH0fFNewQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783873585; x=
 1783959985; bh=em30SwwdrHlyLKjdzvJwFGxqsr1vcfE/w8JSAmSrByY=; b=a
 adRns9hrdhCD3F/W1AzYG9BqxaQZO9PoDLOVbAa6VSveToPweIQPfehk1GJEYEZG
 zm8gwPNnLw+S4xhdgh9ONs1RKRhJvPf+8nGqZ/AzkuyxZtBdN6FIIGRRQGnw+gcA
 Tf97v3P9lJvQbHBoM4TzLT6WnA2r4ppiwityM54DCYqDVzPTKqeDfr2+dafROhIF
 R9gf8j7oUcyzozT/z6hqvtbtcsRf6f+jXKGCkI5ENxSIHvCJMwOpamQOjfVlBC5O
 v3LtxMfgo3dP3kHNHNZKeJoSZx2P9hwDoLE0BWY21LFLxiyFCqQfhdW4/izC8a/G
 b/gqAxQ8Y2JRK0rqFPPEg==
X-ME-Sender: <xms:McBTarvJc5KiH8XqJhStNlbnNpLORz8peJprv0-5NB3oFJ6dWO7KGQ>
 <xme:McBTaozTmUZi8Crsn8fguGHhm7zYhPulHroj_Y9YxumA8gIVLs30hnfDP41sOoipI
 Vpy1srbSv8pgxel0DafLx6C4Cl8REWBVcZmtqkpTq9-Uzp_V9uYJA>
X-ME-Received: <xmr:McBTahjknb-ZKjv9i7w39ilCwgSXfsd_yWfI2W6np6qv9NjXAe8densrn1l-gFskJK-Gn-AnoUbVWrYrOYPnqbI>
X-ME-Proxy-Cause: dmFkZTG4OGwcVYfcK20eQueb0hM+AGNUI3C+4xggafwH3VvhC4I5IH6YVyehyXgVSzCWeG
 o15ZUnAoG7wzL0vZGjvJgwpdS9N47g9W3CsAA6PfY/VjltoUWTikpZ1V1XUaDgowed/WC8
 HSWLHeKlmx/UMOgeyRvlb3QGKoKsJa69Bhk2mVDvQbQEt/iOCXjWaPiG7FrAbCRTQ1LTXv
 4zavBmpc3uLA3z5Y4jRddqolEjPDZSmHzUQaD4mI2RtyfqtBdnWZPKDfjDX1EXXw0/NL+J
 ds71SC4UidFOZY1ds7iIGGMe9urYI49SVOmWJLLzyjnbLdmEYFxja2qgznYLPSJoZt5Ifu
 AnfKhLty+Liyh2RZFjha4HGaGKkmWxJDfkEp6XmVpdemFR7my1Hxaygv2XcFdrVS5/Gv9/
 5zafRLLPksQJLL0yyT0ZObn+i1N5Ifa9sJD/HM4ypl6dmMeqd1sS9erzw56V1buRFiKKGY
 9PwRb13l2JF54fH8Xtea+jCL0C2nGGY3ZwOth/xOTfIMXOK82Hc4ZdD57KYd3BrWRZAXNW
 XIvlsrAzmuCNO27BTdCnjbpBX26BN85Mv79hA/b5wdrVerN7lCcd88qaNIakBmpriGpYHN
 zQnS3cYQ56c7lDTznwpIcbjIzXzFtQ92MxNfAROyMJvdVukXlrII/RkxtJmQ
X-ME-Proxy: <xmx:McBTasBN21_Omax1OeFs64vGeG1HGWIwdwh_6zZ49gRJdlnM-JQ9BQ>
 <xmx:McBTauuQgzlfOZGg__2OOOwYfsTpeVaEPbw-iHG1OP5P0BNRxMmwTA>
 <xmx:McBTahYftjtcb6D1XnfOnQi1qd7xgV32ada3FZC59-4gLYOC77BSrQ>
 <xmx:McBTahV-h7KXrLOf-7dOXFmpqwmxXc1XtDTiqVOwUjJ5hdglrUFWGQ>
 <xmx:McBTahO6c7qukKrEtbCCowl6vExQThPGiMQE8wEZo5YEOgRytVRkRBJG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 12:26:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH] checkpatches: suppress warnings about msleep()
Date: Sun, 12 Jul 2026 18:26:20 +0200
Message-ID: <lc4A5unPQ4GYfqaMw7ayVA@monjalon.net>
In-Reply-To: <20260624162553.79057-1-stephen@networkplumber.org>
References: <20260624162553.79057-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

24/06/2026 18:25, Stephen Hemminger:
> The DPDK checkpatch uses the underlying kernel tool which
> does some checks that are only relevant in kernel code.
> The warning about msleep() time only makes sense in the
> kernel.
> 
> Suppress feedback like:
> 
> WARNING:MSLEEP: msleep < 20ms can sleep for up to 20ms; see function description of msleep().
> +		msleep(10);
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied, thanks.



