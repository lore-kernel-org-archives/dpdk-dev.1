Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF624C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 13:57:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFDC40270;
	Wed, 22 Jul 2026 15:57:01 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id C87314014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 15:56:59 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2993E7A007A;
 Wed, 22 Jul 2026 09:56:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 22 Jul 2026 09:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784728619;
 x=1784815019; bh=+WQT+OjfX2qGFCpX0dpa3LHxYh1pqWN0r+GRxNbbf40=; b=
 CBv4BSPbCvrVQgU5Y/9nVBvrkXrHkxHlXQ+uGuILmQaYKQLNNSNMSh+RSKjHSDPE
 hZW+V8RUk5iIyB5xzHsMj7Q58h6EznMAy9HuHRX+tRAtkuED3+2lmNea4aIojZFo
 Ld4JS5jc+M3AF1NoHgQpmLt6OTL3iE8dhPJHCb+AXZS7ijk4s7Cj3N3NWmV27vKT
 KwOiNYPitkKLTGloGigQCm8x34M70DgNl21MxDnhYsF6v8O7ULeQUF3spN06TTyX
 uMdBL2u9TZ5I64AaaBGWu6naYQH+EMpins4FzkS3zIaOvhnUC29bxPkIJRZjxFLl
 hbro1YmXWXUMheYNaTx7rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784728619; x=
 1784815019; bh=+WQT+OjfX2qGFCpX0dpa3LHxYh1pqWN0r+GRxNbbf40=; b=Y
 +Nx170/UbZwq+WXGte50N95hHYwPyntyfQXj97gJsEvakzI5TiO32Uh0zTgOwEzl
 /iLK2uhflVoKmFG6dYgVJ5KwES4Pl+IkVmYpNZDaHM9UHnACbUkRmbpWg/au3XG0
 2jxLiJ9AePqjNUQJ2re29QZuW3Ui5CcsRVU7O99vl/9nG0a/Q694nKqGTPcdyXk7
 KrISQA0ysGqTd8PfdVvf+zQE4bmYiaPQMeiwwfUJzPg970twjiEu9mqTInCvry9X
 cpSeLZ5B66nHw3NQLqD4bwiCbCBgWtbgxhqZhCH8uMifxyGEHMDJDTTQmWkr/G14
 PEuKqPhGe9Yb2yfrjWtUw==
X-ME-Sender: <xms:KsxgaiKSR3Lj5UScmdvK3aF7ntzfcnkTlbibu4PlrTk8hpGNt_2RJg>
 <xme:KsxgamexxurA_Ff6t1dwRpNZgLdQoXNehry0oF39NRiiIA6Lov_FSzRBiKRHg-IR-
 DIx68bdKmJRdf9JPeeb3o5u01VNh_tQ4ynTYFLVNEQZgS4mvR0GrqI>
X-ME-Received: <xmr:Ksxgalcc72UZMvbh-VXd-vCeeK_5tjUhimOUJFg9R0w7E4PKSll04u6Vna7TeMmeJQ_rpAEDzWC51qfBGZRRN7dfEg>
X-ME-Proxy-Cause: dmFkZTGCrY2NParnoou3NChLnMHJW/JmtKraT+iS3to88H+2dWuedSsDrKf/DTvzrDZeCu
 8t6RBbfpkPCpM/SX1ErLBTiYRiJqeQvoSgy9kntK1bBncVEZ7FiCoyrXQW9X6sFO7YbULK
 HfE04ZMOjyWC7atJNPHl60JmyTn38AUO8XWVoep12Ox+VQZblW/2l4E1hA/CMBPA7Yyfv8
 t7+LbpMSR8fVdTkHceL2A2a9GP/rmJHHXuNtq2Abqj/3LysYFab9Bc6JUepFNVnnqTmJqK
 +XW5nhplb8AjclufNLr11sCXTYq4lU3jJueE76ByTgszeoE1Uqk/nHas5ffM83XWlCXEtI
 Kk8bTgnpd6vrXVPK3HaKj+ZnbUUKpa/aQJ+GIx7ENb+tAn9667tL0IJJGrn+1IVnWIhT7j
 9LUmKuQqqgWEQ9qWUx4D1M7J/KCAtLRMNwQEzCHdwJn8OljwIHvd6tMoDhZJQYhyIOxI3u
 vE4WZvXwPTPUu5/H/5vR/ysOx2sMAAV6ppvrsXltFWwHoAGldii7Y063+nUoQQYzl0tzOU
 O8hKkJR0WP1bfF8WPNVDw/0CIyn35JYzWQW0CREB47OZQsdCBAInHNdVE2citQqk/r+z9K
 vea4qRtFZ8YkCVFnKRzdnpNArAPQMKgCT6b3Henq/cZGkYIsJDsX8vnwTr3w
X-ME-Proxy: <xmx:KsxgapPaDKX_pOfd4juQP5fhnXyZmlA9gP-x3VawXf_tX-CuNk8syg>
 <xmx:KsxgasIYpgBhlDDoUyaiYrpXvDiMelww7bXbtjsl98PShf8t-Z3KLQ>
 <xmx:KsxgaqEfqbfEfvP8CdHSNEAF4xnRzAl0NbFn6Rsq0dCGA6qKhnSOdQ>
 <xmx:KsxgakSbn9Xy5syyO2hqJzkv7uVJbHctHeKDh7U30rgrYYaZlXvWGQ>
 <xmx:K8xgavKdv2GSLyYs6MTiKyPViVe9NYPozLho9Dw5eYhu1rg2xcIKCzJy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 09:56:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Wed, 22 Jul 2026 15:56:57 +0200
Message-ID: <0Jv4NSV_Q32pkSb2S6WOYw@monjalon.net>
In-Reply-To: <20260719132154.84677-1-rasland@nvidia.com>
References: <20260719132154.84677-1-rasland@nvidia.com>
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

19/07/2026 15:21, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 26.07 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Applied, thanks.



