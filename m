Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1384CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 14:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB9F40689;
	Wed, 10 Jun 2026 16:46:59 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 9EFAD40269
 for <dev@dpdk.org>; Wed, 10 Jun 2026 16:46:58 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 1E05CEC01FA;
 Wed, 10 Jun 2026 10:46:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 10:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1781102818;
 x=1781189218; bh=3TAXRQSFLaLFY3jaNQeO7d866oBM738YCQOqWbcmJgE=; b=
 a+aRhS2u72PZXzS9ZFZTQspLoRgg8YxQuSTavpSrWMcRg+JyBc+WxXmn3lxI21vG
 4G5tEB6Iy0DRUxOFDXuJEb7GTWWkJp2s6xmW99EFpL6j9XZJsw658k49dtEtrBd1
 JHH5i96+nEB/Iw8id9Q+ArMUz5UTLxpvcYzsZdt1gVcJ/Pwa1MVzQs3jdJ+T9fr1
 iAiNNlGK40Mr8JpseOWoSMNk8bbPDXi658YGILi9WtAzeaj5QuLDaIS+2FLn9IL7
 ZvyuQqc9V+41QKPWA6wDE0RAomWXyXEvy/c+l51V1imAwyVL4MqwRcshAAveZuI7
 NOQahVaLAcsx7CtAEKuFJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781102818; x=
 1781189218; bh=3TAXRQSFLaLFY3jaNQeO7d866oBM738YCQOqWbcmJgE=; b=I
 Ljh/U6nv3uqOcVerAh5GBOKfibpzEbwZXkrsMdfcy/HpxepNeyTVLUrqSeGVZepg
 HozgY1PVR8fNqkTyuqSsvbUdj7POc91T60bqaP3jKtpnZeZYxtI/AhB12iRpQ/7W
 qyA+dTcw4LAI/9NP+wcr9V30o8lldzXQvdUpyQg/8jzImtsy7g4c55SsEsOp3O1y
 s2/inpSwbuGuvu+iZvz6C0cTFQ3vtUUnRP0zm4ad5gnlLdZ9Z4X3wqu9f0UZWICg
 hIcDTAIIiEb2tgrYYQbQqGSMpGTjIG+g3OSPt4m8y9DkTCkKuGUwwGrdFe7H0kp9
 1ysu9pgfJUaHg5qvxShUw==
X-ME-Sender: <xms:4XgpaivQmTHkdty7p3xcihX8TYR6--bt-Z58C69ewQwJKvkZnNuCWQ>
 <xme:4XgpannFuYv7SfOXiGdyRFZDlE96ZPeo9xa7qWg9dELm4Qm_jZUwsyl2X5Y09vNDc
 uRb7o5f7Kfr352yrScC5YAhA-M_kcEa_m_24m0ZozrzRSm6UE474A>
X-ME-Received: <xmr:4XgpalvU4swWSvPDX0VOfZsY_VkpzbIwbFjK7VOG7w60kJnA2wHuWzSPBwwtssCGcWlMhRv7hRagFy5cgncWzsFuEQ>
X-ME-Proxy-Cause: dmFkZTENqA+RAmdCQvxld+qLtaAHoQG/zlrh7r4a7QcKqSaYZREmLGCRNn4gTIaJiiw5sB
 MV+G0nDY0fex/yT9pA0aByHqxL0V1ZXV18KTNGd6uECQxpEndtui+UrBDoHbMCpzGxMoYP
 +ckjRoKzcW6SiuK0QPJQRKLZpbUnynBDpwntqnVmcgFkl71dv82NzawuKHe/y1a9XqKxct
 DiiolPV8HV7nVYdA70xE96QaXInR6ZnYlC2SHQHM4czawPzA+44zv/RvXB5idjgG7OK/A6
 GKFxRfTRfVUKatQx/Gzb1HWXc4ReLUWyfc39D8pznUOYQP0pgMBEXqn38KNqUXNAWttij2
 KNnXwaqT6IKFkQUPfQnLKa5NzTGq+kE7kXGomHa7+J5bah1NKDRPdhJtfUAMlpoxdFkoZA
 cfK5Etf3mdeuhAllxwXqO+qpYjSQh/bwj5yvMJ4CGvZnEnRBITDxcDAZvq+L3T072KvhU3
 05A/9hv2RScuBzqMq22fwkJPryeooNBOp+aUvuocSHj38EcIjUPtXrue090DKqnNPYLqSM
 VOvpHaQhsMEWFypjqM2M0J/RctBD1in8zG8d6luaVjYD4TzLbu6P6D5Td1bvaqsxOUR2WO
 8xHTJ/wHhRZMnkPS8Oavcraw/8oYAgE93CsV78cS3qgSlvFnFGnFahXyfbcA
X-ME-Proxy: <xmx:4XgpalftcBgH7oQo0y-M6FV-oHwBKGmBUChAFZ3k7fRa2IXwuDx8BQ>
 <xmx:4XgpatxFb4kLypsXty8qZAq80tE7vpPwAfJ47k9hc1fZD7qfNeMH8g>
 <xmx:4XgparF0FIUPyj8s2qyO13yI0N2J7hc5hPz6DVbXI8-hqzaK3_YQbQ>
 <xmx:4Xgpahzr-ch3u8-6jXoHHZYFQbAOv5-U4LJgqgCfjBMzjyYVB58O9g>
 <xmx:4ngpavbk1zN0A43KHtfNNbrUGECk3MB1lRGvAOmyZGtzY3nSsNcfcWin>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:46:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org
Subject: Re: [PATCH v4 02/11] bpf: introduce extensible load API
Date: Wed, 10 Jun 2026 16:46:54 +0200
Message-ID: <n9qJkNlCQDazx_P9i-5XTQ@monjalon.net>
In-Reply-To: <20260520124922.42445-3-marat.khalili@huawei.com>
References: <20260518084912.57006-1-marat.khalili@huawei.com>
 <20260520124922.42445-1-marat.khalili@huawei.com>
 <20260520124922.42445-3-marat.khalili@huawei.com>
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

20/05/2026 14:49, Marat Khalili:
> Introduce new BPF load parameters struct rte_bpf_prm_ex that can be
> extended without breaking backward or forward compatibility. Introduce
> new function rte_bpf_load_ex consolidating in one code path loading from
> both ELF file and raw memory image, with possibility to add more options
> in the future.

Unfortunately, compilation is failing on this patch:

lib/bpf/bpf_load.c:274:40: error: 'struct rte_bpf_jit' has no member named 'raw'



