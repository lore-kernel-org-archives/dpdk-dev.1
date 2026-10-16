Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A3CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E7664029B;
	Fri, 16 Oct 2026 20:22:34 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 832804029B
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:22:32 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c411e139259so18569766b.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792174952; cv=none;
 d=google.com; s=arc-20260327;
 b=W2X4g4kyebxW3DzRjhbGlZkxEoMexXyQggvb6aCgOyq0PQ1rNG3t0wt4jBGGD9kWLZ
 j/xAscm+w0c+Mn8HMslsBmLVKMisES6eZljWk+m/IgmMRaUvrTIRzQ9NG/7j+BHzt6IF
 3A/NjqYWGFEoBPv3dnlknhrcEBvaJYBN2JNImMxKPrvWaWGYW0Clmw+EQ4OCq4OAu5RC
 e0dd24AHlbsGOHP8P2OyS36Mv/zNjd5djQz/I/j805vEY4SzRJg3aCQNY4TSyizy5j0H
 9/tqu1cJ+CqeiVASN9Bhx1QdueQ72zWIfa5a3F3LbkEwqpujK+yL0OAZ0uHPuUC2XMny
 sCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AUiSoYFIAdXwnSznuDCGw5mUKmp28+Knr8sxpWKMAT0=;
 fh=cJN4Ac5M/G+JZuQaENA0c9u2h43wrK4wBf0MKsbItfY=;
 b=cRdvr+72+QlT7GNFtuPhRal8nSXtH3MGi1SbeT8GGdLPlMw7o6orIpWrdwzAvLFhql
 demhzxqPHRtcUv+t4rT73x9kTTeUmg5S3bvZMDdDi9R8Bxe3WydW7HxffJW6gqBvh60t
 tK4RRsWg2i7m17XIptNx//FPRCBsovEcICMPlgTx+rOJSVUGAoTydWhaRXq4A5DbRxOp
 WTRmCMNhL8uGjWBk5VH3iRO+JNE7nyy8KN3ij/L9FkUgJQY15njpQVy1SlDTbV5eMtyS
 QEOCZnrGiltRmKxfvtenIZJQDCkOP1uis6xhY4r4RREi9FwDhk3bbH2rxmiiC+velnO8
 2VOg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792174952; x=1792779752; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AUiSoYFIAdXwnSznuDCGw5mUKmp28+Knr8sxpWKMAT0=;
 b=YslXKsqGuooFGycrTMUe9epJSIasE+P6L+JY9Gtqn0qqIZUZVLe+lPuOnsQCIAST8a
 ZmkxOgFqusc7qOH2f+cLtE5yqSzPqlKj8KSQJBvUtP0rYnsy6aau4l+h1s3kg6Uvl4l2
 N5DZuaVZrQn0xForwVeXnkjGkYZ3ihQWX+y8sMgG5D9wJgKx3ODN38p5oDvphWv3m9B6
 c4Et0g0a9NvRU5j+UgwHMo7S1H2OoUQp8XzpYAP4ycodE/E0DLxnlbW1EHmdjq8ML8xY
 00iynacv++aZ41yKD4nSuJbU/jEuHyBDeeh5G6lYlbDilnxlLsfb1BmZxoAAEbDk6qlC
 SD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174952; x=1792779752;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AUiSoYFIAdXwnSznuDCGw5mUKmp28+Knr8sxpWKMAT0=;
 b=1qL7YiT1FpeM5Vc6ahU8UgzVwA/l9NbARvcriUe4t9tNvbj90vTdV7RtUP7phMsfmx
 P31R+vXNzW4b/NgKTSj2z6Bn/dU4DAq8zleopMDeaTVPNWuMZ61Jg+gF35otaifd3HQ8
 hLw7EwHEkFJAy5zWwzJd1XWwxvOe8iMqgsjur3R24mzxaNKGh9ouwb0QOagpXLjO6/H1
 KJpKOc5ogc8Y/lc38w83+Z/Tt+zFVub/oK/Dx2ZGhcDlNR1hcqVlFDvcMlZuLqMpto0M
 ulkoUKw0GpUiyfx71IAl7O9jFxOHSYF22oL+flgW3I+eieU2AiSetiB+sPPmXDGtiUjT
 mMhQ==
X-Gm-Message-State: AFq9FYKwv5tzW43eRPLQ/OEkUPjJ8ARsP3EmJ4/2t9WJCTFknDK0R7Zn
 d/ea2JNR/DfGhb6k0zL5EEGD2d2Mh6zZ5tYDPAEanr65rlhrrGctJtq3o7ilS+MRfxg3RE6m2/k
 pUGFINQvlwu6A179CRoEHZaZ9IZDBX7reKHMSlTBq
X-Gm-Gg: AYBFou32peZ7aTaDo37gzCgDWzVfN+G1WxXKmi+K+K3J0Ih6ofqYaoxh5eRaa0sVSiL
 beHm3MmulLyoDp4mZyzT1Z/MT++ttFyj3hG4c0xThKIZTNg8ip3XppgnuOuB1kH8vF37j/Q7iuy
 LMBm1VQbuzeg9B3lRBA+sVmZqOLEj0VR4C98mzHkM+lmgXfX8E2q7Q/47IWMQh32yhQ3PyBsYEM
 Lzh6WOKSK+DNFXz+mu/dCuJR8kLOP2tXyu1n0idpX6/93YpnGukhYVjeDOfBo4idfNKHz8rXDcd
 mDOvtLl+uXW1R9M0cF8aV5cZ5qub8GaEQQo1h+SCaYoO9fVe+EXc0pt3
X-Received: by 2002:a17:907:944c:b0:c40:6ed9:b961 with SMTP id
 a640c23a62f3a-c419a05c502mr56779166b.5.1792174949856; Fri, 16 Oct 2026
 11:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1792170902.git.tathagat.dpdk@gmail.com>
 <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
In-Reply-To: <af059fd5b4297695fc4f2fc84236f7d71a71a630.1792170902.git.tathagat.dpdk@gmail.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 16 Oct 2026 11:22:17 -0700
X-Gm-Features: AclHuK9NChhhJXBwG1FnnmUqSbsSUiZoPhC8l3gIBhyFqhG2EQ6itLfBWnQ6yAQ
Message-ID: <CALuQH+WpkTCK6jSgYc0RrdSmV_3MUJ0W8=mrn9wpgQGJRRongw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] net/gve: enforce DQO Tx packet length limits
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org, 
 Jeroen de Borst <jeroendb@google.com>, Rushil Gupta <rushilg@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Tathagat Priyadarshi
<tathagat.dpdk@gmail.com> wrote:
>
> The device requires non-TSO packets to be 17 to 9728 bytes long, as
> noted in the Linux driver, but packets of any length are posted. The
> device treats an out-of-range packet as coming from a malicious
> driver: it drops the packet and disables the datapath, stalling all
> queues.
>
> Drop such packets in the driver and count them in a new invalid_pkts
> counter.
>
> Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
> Cc: stable@dpdk.org
>
> Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/gve/base/gve_desc_dqo.h |  2 ++
>  drivers/net/gve/gve_ethdev.c        |  1 +
>  drivers/net/gve/gve_ethdev.h        |  1 +
>  drivers/net/gve/gve_tx_dqo.c        | 17 +++++++++++++++++
>  4 files changed, 21 insertions(+)
>
> diff --git a/drivers/net/gve/base/gve_desc_dqo.h b/drivers/net/gve/base/g=
ve_desc_dqo.h
> index c1534959c2..d50d88765e 100644
> --- a/drivers/net/gve/base/gve_desc_dqo.h
> +++ b/drivers/net/gve/base/gve_desc_dqo.h
> @@ -12,6 +12,8 @@
>
>  #define GVE_TX_MAX_HDR_SIZE_DQO 255
>  #define GVE_TX_MIN_TSO_MSS_DQO 88
> +#define GVE_TX_MIN_PKT_SIZE_DQO 17
> +#define GVE_TX_MAX_PKT_SIZE_DQO 9728
>
>  /* Basic TX descriptor (DTYPE 0x0C) */
>  struct gve_tx_pkt_desc_dqo {
> diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
> index 1dfbe8f396..53b0a0ec63 100644
> --- a/drivers/net/gve/gve_ethdev.c
> +++ b/drivers/net/gve/gve_ethdev.c
> @@ -1044,6 +1044,7 @@ static const struct gve_xstats_name_offset tx_xstat=
s_name_offset[] =3D {
>         { "errors",  TX_QUEUE_STATS_OFFSET(errors) },
>         { "too_many_descs", TX_QUEUE_STATS_OFFSET(too_many_descs) },
>         { "invalid_mbufs", TX_QUEUE_STATS_OFFSET(invalid_mbufs) },
> +       { "invalid_pkts", TX_QUEUE_STATS_OFFSET(invalid_pkts) },
>  };
>
>  static const struct gve_xstats_name_offset rx_xstats_name_offset[] =3D {
> diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
> index 66cb31dadb..be744d955b 100644
> --- a/drivers/net/gve/gve_ethdev.h
> +++ b/drivers/net/gve/gve_ethdev.h
> @@ -115,6 +115,7 @@ struct gve_tx_stats {
>         uint64_t errors;
>         uint64_t too_many_descs;
>         uint64_t invalid_mbufs;
> +       uint64_t invalid_pkts;
>  };
>
>  struct gve_rx_stats {
> diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
> index 46a03d482d..f686a8c110 100644
> --- a/drivers/net/gve/gve_tx_dqo.c
> +++ b/drivers/net/gve/gve_tx_dqo.c
> @@ -123,6 +123,17 @@ gve_tx_clean_descs_dqo(struct gve_tx_queue *txq, uin=
t16_t nb_descs) {
>                 gve_tx_clean_dqo(txq);
>  }
>
> +/* Validate packet lengths against the device limits. */
> +static inline bool
> +gve_tx_validate_pkt(const struct rte_mbuf *tx_pkt, bool is_tso)

Minor nit (not worth blocking over, but maybe can be done as the
patches are being merged): can this be renamed to
gve_tx_validate_pkt_len? This is one step of many in the packet
validation pipeline.

> +{
> +       if (!is_tso)
> +               return tx_pkt->pkt_len >=3D GVE_TX_MIN_PKT_SIZE_DQO &&
> +                      tx_pkt->pkt_len <=3D GVE_TX_MAX_PKT_SIZE_DQO;
> +
> +       return true;
> +}
> +
>  /* Max descriptors a single packet may use. A larger packet can never pa=
ss
>   * gve_can_tx(): one slot is always reserved, the cacheline overlap marg=
in
>   * must stay free, and up to GVE_TX_MIN_RE_INTERVAL - 1 descriptors post=
ed
> @@ -306,6 +317,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **t=
x_pkts, uint16_t nb_pkts)
>                 tso =3D !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
>                 csum =3D !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
>
> +               if (!gve_tx_validate_pkt(tx_pkt, tso)) {
> +                       txq->stats.invalid_pkts++;
> +                       rte_pktmbuf_free(tx_pkt);
> +                       continue;
> +               }
> +
>                 nb_descs =3D gve_tx_pkt_nb_data_descs(tx_pkt);
>                 nb_descs +=3D tso;
>
> --
> 2.43.0
>
