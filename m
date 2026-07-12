Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60694C43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 15:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A9D2402A7;
	Sun, 12 Jul 2026 17:44:12 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 9CB004013F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 17:44:10 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1773314000C1;
 Sun, 12 Jul 2026 11:44:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 11:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783871050;
 x=1783957450; bh=JVELlR5x7LIRLp9D4JswyMF1QFWt/4znTqT7gXTRlII=; b=
 j6cvTLe5PjXY6zVvWXDO7p0IeBQx0CNKRpPWmajOcaJ/2v+gaV7wcABVQOaLZhqV
 /zAdIGCEgHpdVnqEmX0ann2dZhW1ra3ti0vCLopvOJItn0rko1ncz5UIxcRCOycC
 cvtGrfbOHtYWaY/wGQqtnWOyexJhAO9LHQXVwOw06jWdLMb3bScwIPp+e/vVt+/j
 r15OdluFrB3u+UYaoGLSC/HRlln4nnBVG5i5cqMzmgQiTIBm3AnicNzn3uJs/DdC
 2XKykfMLeD3pz+QpgbfDHOhD+T+oDhzhIqyQ74t5e49PVOO7HCgA25qJ96nIYpg6
 w+BObpyPEHvW71EvxMCXYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783871050; x=
 1783957450; bh=JVELlR5x7LIRLp9D4JswyMF1QFWt/4znTqT7gXTRlII=; b=l
 ZYYXEncmCWZH3xR9QCRWc3Rw+CVWeBEUGyCcM/tMCzqaWuPDe718P2I/uqTrFxgW
 0Z2UnGkDTpCKF3SO5T6JO4SIygJeyAtOh7cWjWBSxnET4jmoD6aBu3UlOFkLk+fR
 eXr/fjacuO3Afak0179Z2gj2wjGCm5n0CAIh93HdA7zDMCTAVPhDbKgPnwluPPEz
 RrUKBNEECfToD8NP5BDyt77ah/Uf2uoRM3lg/8GdDr9hgH9keGLmBFHsyZgLujY6
 2sX4/Mx/9K0+0lo4IsQZVnnpiABWEEZFTEwx0RX9FXd5ctnNz2ANUbr3RoNQFNs4
 uqCVx0YlwwmsE6osv8yTg==
X-ME-Sender: <xms:SbZTanceJ64L58AJrJdy5n6b5WXwEXgtqwJuHoP3zUDY40u11EtBvg>
 <xme:SbZTausMXBli4J-kA9Q8mD8i8gX7E5xW1bEJq-7vfWQC2wFBL-RwR8lE5A5zV1Ti0
 NlQqFHopGLg8g1qyx30QP1p4Us5Ow6HZJzHAc6RKIfHniA94Z-DdA>
X-ME-Received: <xmr:SbZTaglfhme9CYkSMS0y63NokoEuRQ6ie3QtPU6nPjTqhjUkCYRaEFCv_QV5X190CI5p1KpcvIERrzAv0mkd1ic>
X-ME-Proxy-Cause: dmFkZTE0Y57aBLAiXP5SG5T00v0T+YCkT1fg0vzVyvNsU23czTGWSUZ1qAY0NJbN23QkgH
 Zasys1f5yG+RgeYqIeJczvdsDy2rWLfUMM0LH2DWIxYCPIjfxXuiTHv61hWPtkwNaN+E1I
 QhFTRdAQSrQCkmIGi+YI9pt0v4BlwHktaMk95aWxtiHVQee4gGpB4w86tpzxRbmJ0wJZdQ
 rwSL/1fFW6njKgm7ZftS8HCyu8PJYg4lVvMJb0y3Rn0JbzZ3AtJdjD3MxXzkkmWQFM6WjU
 a/quCPk8x67JHwfG2LqIbUYCyj/AVjIumDvj+kTt4fnZoUYCs6+xHC8PQWM520VTOyyuR4
 RSa5ZXXhpteGFVhpf73dhuHX4pHf0d+uiYyzDP1+Ll02kCzGjt/ivFMU2dNJs0o3A0xy7Q
 ki3qNS8lBxVZHitcIW+hVD9iJ+HGBXweuSqO/9nOui2DM9DLbNjL6F14y0QPPZOyLNE9VS
 EZabqbm6PBukj2xkRV12SZwu96h4KTxFNchwiIxxuV1yM8YCCBi/FXYGQ4BdC7n6BCRb4z
 JPs9Sb79qV+Z5pd3c1kZ+ppn/3xkSLw9CsXub5219xAqvqhg4pKkLgQOBCk3s/4m97gRE0
 2mH5QqEB1FvQbo7dFtjmUFoJOgmCV2mlezPbKYVbmXhWzvE1yq2MBjuC5NVA
X-ME-Proxy: <xmx:SbZTaozm4DulHSnOK52nwdf0uC88J_5R_sOlC8MuVRdAW7rTuqTJyA>
 <xmx:SbZTaqM5LdXsDZ0kqZ73fxvWETEbkDaWKJ3vyGL5H-VidFSYXy9mDw>
 <xmx:SbZTaso9v9njmj_h-gucY6qcwmTCr7m-VnWcTvaEXScsx4DdTpnVNw>
 <xmx:SbZTarEl7PLJi3QWX0U7jpHBl_3wg0qw0eHOfMu21LASIhk22gtH5w>
 <xmx:SrZTarIsTeg91Pof7LXfbbaIIaItpb2BZhWboo9Rz8RXRvQmILjRG0MV>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 11:44:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Matthew Gee <mgee@iol.unh.edu>
Cc: dev@dpdk.org, stephen@networkplumber.org, aconole@redhat.com,
 lylavoie@iol.unh.edu
Subject: Re: [PATCH v3] tools: AI review handle empty Error sections
Date: Sun, 12 Jul 2026 17:44:04 +0200
Message-ID: <CuzZJHWKQcyfa7PHW-BHQQ@monjalon.net>
In-Reply-To: <20260617174402.2123568-1-mgee@iol.unh.edu>
References: <20260612190225.1016275-1-mgee@iol.unh.edu>
 <20260617174402.2123568-1-mgee@iol.unh.edu>
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

17/06/2026 19:44, Matthew Gee:
> This patch fixes a bug where review-patch.py would detect and report an
> error or warning only based off of the occurrence of the headers of the
> error and warning sections. This led to consistent false positives as
> often AI reviewers will create the header but put "none" or similar
> filler text within the following body.
> 
> This patch updates the code in order to check if the AI review has a
> body with error or warnings to fix and not just filler text. This is
> done by keeping track of whether the for loop parser is within an error
> or warning section; analyzing the first non-whitespace line within the
> section. If the first non-whitespace line matches known filler then the
> section can be ignored.  It has been observed that if the AI includes
> filler then there is no actual concern.
> 
> These changes were tested against 10+ markdown AI review outputs with
> several variations in formatting and filler text. The changes caught
> error or warning sections with actual concerns and successfully ignored
> sections containing only filler.
> 
> Signed-off-by: Matthew Gee <mgee@iol.unh.edu>

Applied, thanks.



