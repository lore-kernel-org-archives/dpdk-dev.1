Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2377BCA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 10:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6878440279;
	Mon, 18 Aug 2025 12:58:32 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 9E95D40279
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:58:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c58l14gj7z2Dc1W;
 Mon, 18 Aug 2025 18:55:41 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C943C1A0188;
 Mon, 18 Aug 2025 18:58:27 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 18:58:27 +0800
Message-ID: <d4859ac6-2119-40b5-9e3b-ae88d56dc690@huawei.com>
Date: Mon, 18 Aug 2025 18:58:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Drop support for undersize packet mbufs
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <stephen@networkplumber.org>, <andrew.rybchenko@oktetlabs.ru>
CC: <dev@dpdk.org>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FE42@smartserver.smartshare.dk>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FE42@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 8/18/2025 4:11 PM, Morten Brørup wrote:
> Why does the mbuf library support packet mbufs with smaller data room size than RTE_PKTMBUF_HEADROOM (e.g. [1]), when the Ethdev drivers (e.g. [2]) don't support it?

Maybe the pktmbuf which extbuf, which the data-room-size is zero when create pktmbuf.
After detach from extbuf, the data_off should be zero instead of RTE_PKTMBUF_HEADROOM.

> 
> This goes all the way back to the first public release [3].
> 
> It seems crazy exotic, and should be removed for simplicity and a potential performance benefit.
> What am I missing here?
> 
> Instead, the rte_pktmbuf_pool_create() functions should check that data_room_size >= RTE_PKTMBUF_HEADROOM.
> 
> 
> [1]: https://elixir.bootlin.com/dpdk/v25.07/source/lib/mbuf/rte_mbuf.h#L941
> static inline void rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
> {
> 	m->data_off = (uint16_t)RTE_MIN((uint16_t)RTE_PKTMBUF_HEADROOM,
> 					(uint16_t)m->buf_len);
> }
> 
> [2]: https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/i40e/i40e_rxtx.c#L609
> mb->data_off = RTE_PKTMBUF_HEADROOM;
> 
> [3]: https://git.dpdk.org/dpdk/commit/lib/librte_mbuf?id=af75078fece3615088e561357c1e97603e43a5fe
> +static inline void rte_pktmbuf_reset(struct rte_mbuf *m)
> +{
> +	uint32_t buf_ofs;
> +
> +	m->pkt.next = NULL;
> +	m->pkt.pkt_len = 0;
> +	m->pkt.l2_len = 0;
> +	m->pkt.l3_len = 0;
> +	m->pkt.vlan_tci = 0;
> +	m->pkt.nb_segs = 1;
> +	m->pkt.in_port = 0xff;
> +
> +	m->ol_flags = 0;
> +	buf_ofs = (RTE_PKTMBUF_HEADROOM <= m->buf_len) ?
> +			RTE_PKTMBUF_HEADROOM : m->buf_len;
> +	m->pkt.data = (char*) m->buf_addr + buf_ofs;
> +
> +	m->pkt.data_len = 0;
> +	__rte_mbuf_sanity_check(m, RTE_MBUF_PKT, 1);
> +}
> 
> 
> 
> Med venlig hilsen / Kind regards,
> -Morten Brørup
> 

