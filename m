Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EA606A332
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=K11P78hh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB0940297;
	Mon, 19 Oct 2026 23:10:20 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 85BC74021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:10:18 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-33.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-33.yp-c.yandex.net)
 by forward501d.mail.yandex.net (postfix) with ESMTPS id BEF2A80622;
 Tue, 20 Oct 2026 00:10:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33 with ESMTPSA id
 BAhVx1ffTCg0-OGQDDWSX; Tue, 20 Oct 2026 00:10:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792444215; bh=cAJ7Qp2n71MhFer5CpRXwC3xM8xR9M0kqdqrzsKUIBc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=K11P78hhgBka2sL1U39JCGkdu5RqlV7LhzZd/DXK/tnzUqpS446WJXeEjDoh+2HCJ
 P7ifygycxi9X8ubuXPc3j4XnWUikDayAxtPvYxOVdGONvpipK/Ix0vjXenUiPeh8tq
 pJmSw0hNtoBcHQu4rIlbSh7+cPGapGQmf2dz8Ius=
Authentication-Results: mail-nwsmtp-smtp-production-main-33;
 dkim=pass header.i=@yandex.ru
Message-ID: <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
Date: Mon, 19 Oct 2026 22:10:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
To: Marat Khalili <qm2k21@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261012210917.161343-3-qm2k21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> Document the data plane limitation in the file docstring of
> rte_bpf_ethdev.h: packet callback execution expects only one
> thread per port/queue pair at a time, making concurrent bursts
> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
> or multi-threaded software PMDs) unsupported.
Not sure what do you mean by:
'shared RX queues' and 'multi-threaded software PMDs'. Can you probably 
clarify?
>
> Rephrase the existing control plane multi-threading limitation
> to explicitly distinguish it from the data plane requirement.
>
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---
>   lib/bpf/rte_bpf_ethdev.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/bpf/rte_bpf_ethdev.h
> index 686fda8d94..cf3b4048f0 100644
> --- a/lib/bpf/rte_bpf_ethdev.h
> +++ b/lib/bpf/rte_bpf_ethdev.h
> @@ -10,8 +10,12 @@
>    *
>    * API to install BPF filter as RX/TX callbacks for eth devices.
>    * Note that right now:
> - * - it is not MT safe, i.e. it is not allowed to do load/unload for the
> - *   same port/queue from different threads in parallel.
> + * - in the data plane, it expects only one thread per port/queue pair at a time.
> + *   Calling RX/TX burst functions concurrently on the same queue (e.g. when using
> + *   RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues, or multi-threaded
> + *   software PMDs) is not supported.
> + * - in the control plane, it is not MT safe, i.e. it is not allowed to do
> + *   load/unload for the same port/queue from different threads in parallel.
AFAIK, all CP ethdev API is not MT-safe.
Not sure there is a reason to put it here again.
If you believe it is, then probably worth to mention that it follows 
ethdev CP API convention.
>    * - though it allows load/unload at runtime
>    *   (while RX/TX is ongoing on given port/queue).
>    * - allows only one BPF program per port/queue,

