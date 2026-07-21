Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D8C4452B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 21:25:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9B8C402B5;
	Tue, 21 Jul 2026 23:25:16 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 23D4E400EF
 for <dev@dpdk.org>; Tue, 21 Jul 2026 23:25:15 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 941E1EC01AF;
 Tue, 21 Jul 2026 17:25:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 21 Jul 2026 17:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784669114;
 x=1784755514; bh=HcTtjdpRYv5KobKilL1yIO1ESj0PXs+iThsBtYzlrpg=; b=
 d+1xR3B+Fb8vHNSkiLmrrcgK6gONq8MsW7Uk74dEKHhRGcin1IbnwEZf7BbQKKqZ
 fSr428LRF4gbO9064b+ShF7BNSZCSZ/csU1VZ+IcG+xrdpPs602z/rL1922NfYSB
 EuLXojVVDdf3SnxAt8gMC6br0xrIuLSiBumVPy3RhQ1NJOKM6jHwt1hwxSN/oVcp
 MMCACHv/bVQE0/AVON8+3RKKzHwySdhWo7y1c7SgiBeTSM4uaW9FtmRwlzzGsMZz
 cpQlkX8rmUG87S+FjutJkYvP8/AssMTU8sQ9kEgk2qIrWWaL41sdECmiv6l9yVHK
 zhOELYtxJ+6y9N2bv5y+jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784669114; x=
 1784755514; bh=HcTtjdpRYv5KobKilL1yIO1ESj0PXs+iThsBtYzlrpg=; b=a
 mLytj63tNCNplpI+/lVHzGFS1XTt5QzNQYB7V5Jhb5JMfl3FEpQT/MQLd5TFFesP
 FemwfBDaQrnYI3C/fAEoBkLZ+UtmkCrGAFaG7Ijl0puI6htdbixL+F+Jy3wX+78x
 9x8SuYKqBk6cqcLX/bMrOuIIEuKqNtHrPKn7MU+zWHbnUdc6UY3oaReVmC9+w1ja
 YciqL0EwhjuhlVN2i1UaGFd/nxFb5wKIEMPCf1c7hCgPJeVkNHJy1w9RyPRR386R
 /sMpkVcw7t7VYZw4JEzDtUgwi1RpxyNLyN56Te7Wg8S0Gh7Ywl1KvLAoPrccenHn
 NKU8E6jZSdzjj+aVXiB1Q==
X-ME-Sender: <xms:ueNfavBCWV8RJ9trICscc5IiDkyj-o5djIcj9hMnCBGvLBHsvgU6ag>
 <xme:ueNfamOOFC8L5Ak-wt5KqWdM1nz_QvdzR2PYcJorCQGR1H-sf2UlZUhMc9xb5H0fS
 gh2xR6Fau8x_80_bA7OX4LE9z9Mk78Lb4vtHJRltu_Q92LoPOdViQ>
X-ME-Received: <xmr:ueNfaoxmpui6k7EHyQKguLLsKfltL5bBMTysaLu7uFGvlQ4d7p7NsVx022opeYNlgyHwqOHGTckgY6oC2GkszZR1Tw>
X-ME-Proxy-Cause: dmFkZTEPBSHW0Y/1iu77uOkUrjFhgDmB31Pzp4ms8B7e/mg6h7bA5xUYQiWJSB+C9bcr4/
 YivWgJ1kEDmSo9SCWCTgXvBdfZm5YxlBN0uj6JvY0DT4btAZ/anNc3VtOEZrf7w4tKdCuD
 ENPOBMavlUWeE5BkFQZEgCXWle+2f2N4DeqDUrcjMfIEmSwL07gw8KS8yBgyE0V7LpI7Nf
 HqDyHt80ZbGiav9W+HrLjALQWWAXO91fOpNKGvRWpm5ZpgYEVVeYcUzFGd/QpHmjGExOza
 ouF/zUAIgCa1EEb0wqRdbxS/PItg5Bzhva5XPvWTyvuJVcVMObWpR3Av4YTPn0kMIzeUMI
 mtLnJMkcvrClX5r5/7r61AMCxtwCunrF1oaaFYA64f5RpZ4HZ1+XemIjB0A9MZz3zI3435
 kbYXkRSdFfAtz+DvZOB4/kKvln4Hcl+ghk1igdEJ6O68OtGla7pZ/acW5IT74hYFS8Z2CH
 6C8JZRan9iUibm9Q/gQN9XTOuU4B7Y+H6Eg4eosXoG5xkQNp7VG6ZyQ/7t3Cy5oL5ixXfO
 XxYSNKM2MKs5sqA6rHEG6Ltlt7isu5e/BFJ9gI29S8zDIowBllacOnNwuHGM4eCL2mhr+p
 GvclWw1l+LppqiMkPgetJv9B0FJxdJX0PCVQIYXy09ugFzkjIwQgI/Nr7+QA
X-ME-Proxy: <xmx:ueNfamXRWNK8_9Ctl4xcFd27UguU9r9CZi3zWzxmtG4YpHhLqE4_2g>
 <xmx:ueNfaqNB6G5EPTCUDEcL2dDvOp3uSykyUfrkoo3MVELowGkI-gkThA>
 <xmx:ueNfaoBfiU5wR3gWTJDTih6bMJruJnuHRAXyU8ZpgrvFGHJqjWYWng>
 <xmx:ueNfandn13krDOZDQcL7Pw40_z9xncJKDTKg8ecXrN8Ngsal2vMBzw>
 <xmx:uuNfapPjAHl0P8ixd6DBM02cxyIJWejsWGBtpeAxJXp1eXRKKevkIWeb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 17:25:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Maxime Leroy <maxime@leroys.fr>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, Gagandeep Singh <g.singh@nxp.com>, 
 dev@dpdk.org, david.marchand@redhat.com,
 Hemant Agrawal <hemant.agrawal@oss.nxp.com>
Subject: Re: [PATCH v1 1/2] net/dpaa2: revert inner RSS level support
Date: Tue, 21 Jul 2026 23:25:10 +0200
Message-ID: <SIzst5xFTHeltCemdlXt4A@monjalon.net>
In-Reply-To: <b4bd7d94-20b9-4e7c-b51c-7d428bc60b0a@oss.nxp.com>
References: <20260630123857.392884-1-maxime@leroys.fr>
 <gMKBpMOZQYuU_7FGO7uhXg@monjalon.net>
 <b4bd7d94-20b9-4e7c-b51c-7d428bc60b0a@oss.nxp.com>
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

21/07/2026 14:55, Hemant Agrawal:
> Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> On 21-07-2026 15:26, Thomas Monjalon wrote:
> > I'm waiting for an urgent reply from the maintainers here.
> >
> >
> > 20/07/2026 15:34, Maxime Leroy:
> >> This reverts commit 618a06c53d479ae576ff01c7d274b10c60b3d3d5.
> >>
> >> RTE_ETH_RSS_LEVEL_INNERMOST was mapped to the innermost IP instance by
> >> programming the IP key extracts with hdr_index = HDR_INDEX_LAST. The
> >> hardware only resolves that index when several IP headers are stacked.
> >> A non-tunnelled frame carries a single IP header, so the extract
> >> resolves to nothing, the RSS hash is constant and every such frame is
> >> steered to a single Rx queue.
> >>
> >> The ethdev API defines INNERMOST by encapsulation level, not by the
> >> presence of a tunnel: a plain frame's innermost header is its only IP
> >> header and must be hashed. The dpaa2 hardware cannot honour that and
> >> keep true inner-only semantics for tunnelled traffic at the same time,
> >> so the level cannot be implemented correctly as merged.
> >>
> >> Revert it. Hashing the outer plus the inner IP under the PMD default
> >> level, which spreads both plain and tunnelled traffic, is added in a
> >> follow-up.
> >>
> >> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Applied, thanks.


