Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD7CD4F5E
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 07:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 694534065B;
	Tue, 19 May 2026 09:06:56 +0200 (CEST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net
 [178.154.239.147])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE69402D9
 for <dev@dpdk.org>; Mon, 18 May 2026 18:44:22 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:25b4:0:640:a124:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id E8B0F80613;
 Mon, 18 May 2026 19:44:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id HiTlaaESquQ0-u4etTfL8; 
 Mon, 18 May 2026 19:44:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volta.cloud; s=mail;
 t=1779122661; bh=VRb7YiVUSMKzGY1i69yBkQJROPR4EXkdFn9wgz4vF50=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Fbd/B75IjIeVEtfIwNfpqkxWJyckBIomzQGHJabHKh6OfzKsOe90fl48hniyb7xTg
 +r+vRPw5EyE8KlXRVoVaks6f1PSsrQcL3638/rd+JsRCuPArVJQ7QWTkn4JEJTpz5z
 yDWG9C9/2NRix93w1oSAcckP0F6qxVpyFd2deuEk=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net;
 dkim=pass header.i=@volta.cloud
From: Max Makarov <makarov@volta.cloud>
To: dev@dpdk.org
Cc: igozlan@nvidia.com, valex@nvidia.com, erezsh@nvidia.com,
 suanmingm@nvidia.com, bingz@nvidia.com, kliteyn@nvidia.com
Subject: [QUESTION] mlx5/hws: format_select_dw_8_6_ext gating on standalone
 ConnectX-7
Date: Tue, 19 May 2026 01:44:16 +0900
Message-ID: <177912265651.29998.6928116123708055888@volta.cloud>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 19 May 2026 09:06:54 +0200
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

Hi all,

We are building an SDN/IaaS data plane on ConnectX-7 using DOCA Flow and
need IPv6 Connection Tracking. CT pipe for IPv6 requires the 11-DW jumbo
STE format, which is gated by HCA_CAP_GENERAL_2.format_select_dw_8_6_ext
(full_dw_jumbo_support in drivers/net/mlx5/hws/mlx5dr_cmd.c).

On all three of our standalone ConnectX-7 SKUs (PSIDs MT_0000000838,
MT_0000000840, MT_0000000892, firmware 28.48.1000) this bit reads as 0 in
BOTH GET_CUR and GET_MAX modes. We have verified the bit is not affected
by any documented NV-config TLV (tested ~20 candidates with mlxfwreset).

Questions:

  1. Is this capability silicon-locked on standalone ConnectX-7, or could
     a future firmware release expose it?

  2. The DOCA Flow CT documentation states "BlueField-3 and above is
     required for IPv6". Is this permanent product positioning, or is
     there a roadmap to enable it on CX-7?

  3. For existing CX-7 deployments that need IPv6 stateful CT, is there
     a recommended DOCA Flow pattern (e.g. splitting the 5-tuple match
     across multiple 8-DW STEs while preserving CT semantics)?

Happy to share full HCA_CAP dumps or any diagnostic output that would
help.

Thanks,
Max Makarov
Volta Cloud
