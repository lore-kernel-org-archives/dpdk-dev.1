Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F9C83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C2840B9C;
	Wed, 23 Jul 2025 15:31:36 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0D33340B98;
 Wed, 23 Jul 2025 15:31:35 +0200 (CEST)
Received: from debian (unknown [78.109.70.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id E78A2E0568;
 Wed, 23 Jul 2025 17:31:33 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am E78A2E0568
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1753277494;
 bh=v3muQDJellV2P5/onfm0d8R0FAvGxeviGiZ+9npvikE=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=BkfdOaI62nD4ZU8cEKc1Q8QXQxkANU5lp9+li7Yc9uw1E9DCwQc+J6gRdCPUSDLJP
 6QrxpO4A44pWOzR7XjJ16kwjZ0RDbiHaiT6eF33dpTlNYkRHyKcM2vRICWfW3UXcJy
 7GXfovGWurU7+IjoLpeUrOqOXEvnVjIznDJx/JC1oPvXXfd+ZHLztvXyB6YzUGwi+r
 YB414GKiMQM6aC08fwoOTailQNTxh3vK/WiRu+jV96boLvI4sduCw1JVieLYsy9QuV
 oH65dY1NthSwx6R7hCio5qXM/KJ/58TGCQxoquliba/AGuusOzNbdhCU48iGX70etM
 RZriCuuMicL+A==
Date: Wed, 23 Jul 2025 17:31:32 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
cc: Stephen Hemminger <stephen@networkplumber.org>, 
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, dev@dpdk.org, 
 dpdk stable <stable@dpdk.org>
Subject: Re: [PATCH v2] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
In-Reply-To: <CA++2-x5vbQKk4PJRL8D5QD3iNM5jBh7fwd=qk+2gRvwsd59_3A@mail.gmail.com>
Message-ID: <f15505eb-057c-f08f-5ae2-3be3c18d1252@arknetworks.am>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
 <CA++2-x7U1D8pB1dzuyoeQ4WQKcCpv32HVji23Ev=cdM=G9MROA@mail.gmail.com>
 <CA++2-x4qtuSz1HCA5BF6gybpaUhAivmeCCj3B_eURZJL5pLh-Q@mail.gmail.com>
 <dbf3b51a-7bd8-2f48-a038-5e7b92994e07@arknetworks.am>
 <CA++2-x5vbQKk4PJRL8D5QD3iNM5jBh7fwd=qk+2gRvwsd59_3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-983534878-1753277495=:19156"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-983534878-1753277495=:19156
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 Jul 2025, Khadem Ullah wrote:

> Thanks, no. Can, I ?

Typically, the patch author (as indicated in their respective e-mail address)
can sign up for patchwork account, sign in and mark any of their own patches as
superseded, in order to help the delegated reviewers tell new from outdated.

Thank you.

> 
> On Wed, Jul 23, 2025, 18:24 Ivan Malov <ivan.malov@arknetworks.am> wrote:
>       Hi Khadem,
>
>       On Wed, 23 Jul 2025, Khadem Ullah wrote:
>
>       > Please check v3 of this patch.
>
>       Checked. In the meantime, you're not overlooking to mark previous versions [1]
>       with status 'SUPERSEDED' in DPDK Patchwork, are you?
>
>       [1] https://patches.dpdk.org/project/dpdk/patch/20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk/
>
>       >
>       > On Wed, Jul 23, 2025 at 5:19 PM Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>       >
>       > Secondary application not only breaking on device closing,
>       > it's also getting segfault when we do "show device info all" from secondary
>       > after primary closes:
>       > testpmd> show device info all
>       > ********************* Infos for device 0000:03:00.0 *********************
>       > Bus name: pci
>       > Bus information: vendor_id=15b3, device_id=101d
>       > Driver name: mlx5_pci
>       > Devargs:
>       > Connect to socket: 0
>       > Segmentation fault (core dumped)
>       > This patch prevents these crashes and it seems that these fixes should be in PMD along with the ethdev layer. Some more checks will be added in the next version to prevent
>       "show device i
>       > nfo all" crash.
>       >
>       >
>       > On Wed, Jul 23, 2025 at 9:50 AM Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:
>       >       In secondary processes, directly accessing 'dev->data->dev_private' can
>       >       cause a segmentation fault if the primary process has exited or if the
>       >       shared memory is no longer accessible.
>       >
>       >       This patch adds a safety check using rte_mem_virt2phy(), with an
>       >       unlikely() branch hint to minimize performance impact in the fast path.
>       >       This ensures 'dev_private' is still valid before accessing it.
>       >
>       >       Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
>       >       Cc: stable@dpdk.org
>       >
>       >       Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
>       >       ---
>       >        lib/ethdev/rte_ethdev.c | 7 +++++++
>       >        1 file changed, 7 insertions(+)
>       >
>       >       diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
>       >       index dd7c00bc94..ef5dc55f2e 100644
>       >       --- a/lib/ethdev/rte_ethdev.c
>       >       +++ b/lib/ethdev/rte_ethdev.c
>       >       @@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
>       >
>       >               if (dev->dev_ops->dev_infos_get == NULL)
>       >                       return -ENOTSUP;
>       >       +       if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
>       >       +               unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
>       >       +                       RTE_ETHDEV_LOG_LINE(ERR,
>       >       +                       "Secondary: dev_private not accessible (primary exited?)");
>       >       +                       rte_errno = ENODEV;
>       >       +                       return -rte_errno;
>       >       +       }
>       >               diag = dev->dev_ops->dev_infos_get(dev, dev_info);
>       >               if (diag != 0) {
>       >                       /* Cleanup already filled in device information */
>       >       --
>       >       2.43.0
>       >
>       >
>       >
>       > --
>       > Engr. Khadem Ullah,
>       > Software Engineer,
>       > Dreambig Semiconductor Inc
>       > https://dreambigsemi.com/
>       >
>       >
>       >
>       > --
>       > Engr. Khadem Ullah,
>       > Software Engineer,
>       > Dreambig Semiconductor Inc
>       > https://dreambigsemi.com/
>       >
>       >
> 
> 
>
--8323328-983534878-1753277495=:19156--
