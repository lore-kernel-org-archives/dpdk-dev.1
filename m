Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC84CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 02:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3B29402A7;
	Mon, 18 May 2026 04:22:26 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 6441940264
 for <dev@dpdk.org>; Mon, 18 May 2026 04:22:25 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f36da5c8fbso1397324eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 19:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779070944;
 x=1779675744; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ii7ga4ehCwqsMZqex1mdVh6edtRc9nLCtnwaRri720=;
 b=oGhS40A0AaZBLmmjaqh8GPnU8MlBkB3hhJiR7pDga+lIbtga8DgLDMfmxhpFbeiP4N
 Va42/+G378Khdm1WeVnQP5+0B0Fj32yQm3HVaG2X0UQx5+gDZkTrscMXloU0GHP/V5g6
 S5VvDpTXVXY/zb1acE3W6D2dnHSsvDGatalKZNAdbN4mwJ4/YsEO3FD8aGCpexCG6Zn5
 3jphZzXWLn9AEzN4pBq9wK4wips92zohR2WnUHjlsIS06ixMDRgNpYxmPEgle6mmqDFM
 Pr96S3puBeM1saCc5Z8jQ3euj1J0XKrEUqMNWZVXnMwp4gEDPFVU7KRPlvu3PLY4s/NI
 iufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779070944; x=1779675744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ii7ga4ehCwqsMZqex1mdVh6edtRc9nLCtnwaRri720=;
 b=JcgekpXl7bmKxXQGBq6llmhkczqTgkbNZ2IVUHaBJ3jfrg7oGvbenO3wbhzdHfST/k
 AvtJGIxJkQ3w0LwNyKFKRUTsobZNTM9h2kSrb1SzPR5kgM7cy1pBBmZEIj9+9gZzWTmK
 yA+VgDogG9OoTNA8ePjUUp3CadlrJ4W4iFp0Bslu51yX5JwVhhbTbILomEyFFDC/m9az
 LAlS06pdbXDewOzXb2Wb8QIoery2VuOvyATApVFZpcu+wUpyTpiH21Ah2L6+fROUfl9K
 sHXwoyxd1/HNka/+UI1rETCdHz4DMLddLyWqxRd0F3dEWLkLfg/nSXZVVBbyqJ0TKutp
 YN4w==
X-Gm-Message-State: AOJu0YyCiUy1BnrOQAeZxlLDlMHqB+Sbzn9JlFPZFU8YqXVjpT/6cxT+
 2/30Xk8lHp9hyQYaFwBsMj+pPmWYBNWHXsi7+EMOzBYffl6WEFiIkRuD/kGJzKCMurj7EMkb1h7
 EDnp8AaA=
X-Gm-Gg: Acq92OHAsIT7cYHXoGZePzmXclJVC53CFawF/aAGqnGyUjAuEHw59fK8Ii5ErlC5624
 gqhrmCCp1hROLsxIvVMTVK2AfBgkB/OtnUnqoNIl+6Pvz5HvoT7luoxN0xe8hS7Tgxbw1B+R00I
 LkgAzJX3MsSjjKJsXUP+/HWGZdT9owty1d7xv+QTPSQyIhWTUD1wuEqmK1dHjaQ7+1xurtoPqQZ
 bemXClQaxwCtkjT1SJ8IyjjjrO5vCDo4l0CwYefRrXuQWsdRiz0EEumtutaDP/2vvk17YtkR+3d
 hPuoJyLgRXbaT7zQeiIXLswW0YA9TMJJY4AYx+LRb6H3G9y+zIE/TRtH27ayNzJzthhwVqqePtR
 WZDacv+kcU+EIdQT7r00t1hvHiL6z8ji1hb/i4iiTvJMY/CAuyACncXj96Ow8nEDMg6D79Psxdg
 S93mClqFNSxLwkgj2SJkqzICu8zKgLuWInzQc=
X-Received: by 2002:a05:7301:4184:b0:2fc:9d97:d59a with SMTP id
 5a478bee46e88-303986ad3c0mr5757070eec.32.1779070944107; 
 Sun, 17 May 2026 19:22:24 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978afdd3sm12995294eec.29.2026.05.17.19.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 19:22:23 -0700 (PDT)
Date: Sun, 17 May 2026 19:22:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 3/3] net/zxdh: optimize Tx xmit pkts performance
Message-ID: <20260517192211.139e1a92@phoenix.local>
In-Reply-To: <20260509062930.3254766-4-wang.junlong1@zte.com.cn>
References: <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
 <20260509062930.3254766-1-wang.junlong1@zte.com.cn>
 <20260509062930.3254766-4-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat,  9 May 2026 14:29:29 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> Add simple Tx xmit functions (zxdh_xmit_pkts_simple)
> for single-segment packet xmit.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>
> ---

Some AI review feedback.


PATCH v3 3/3] net/zxdh: optimize Tx xmit pkts performance

Error: NULL pointer dereference in pkt_padding()

hdr = (struct zxdh_net_hdr_dl *)rte_pktmbuf_prepend(cookie, hdr_len);
rte_memcpy(hdr, net_hdr_dl, hdr_len);

rte_pktmbuf_prepend() returns NULL when headroom is insufficient. The existing zxdh_xmit_pkts_packed() path guards its push fast-path with txm->data_off >= ZXDH_DL_NET_HDR_SIZE and falls back to the indirect path when that fails. The simple Tx path has no such guard; any mbuf submitted with headroom < hw->dl_net_hdr_len will crash here.

Add a NULL check, or screen mbufs with insufficient headroom in zxdh_xmit_pkts_simple() before calling submit_to_backend_simple().

Error: out-of-bounds read in zxdh_xmit_pkts_simple() stats loop

if ((vq->vq_avail_idx + nb_pkts) >= vq->vq_nentries) {
    nb_tx = vq->vq_nentries - vq->vq_avail_idx;
    nb_tx_left = nb_pkts - nb_tx;
    submit_to_backend_simple(vq, tx_pkts, nb_tx);
    ...
    tx_pkts += nb_tx;
}
if (nb_tx_left) {
    submit_to_backend_simple(vq, tx_pkts, nb_tx_left);
    ...
}

zxdh_queue_notify(vq);
txvq->stats.packets += nb_pkts;
for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++)
    zxdh_update_packet_stats(&txvq->stats, tx_pkts[nb_tx]);

When the ring wraps within a burst, tx_pkts is advanced past the first chunk. The stats loop then walks nb_pkts entries from the advanced pointer, reading past the end of the caller's mbuf array. The first chunk's per-packet stats are also skipped.

Use a separate cursor for the submit calls and iterate the stats loop over the original tx_pkts, or accumulate per-packet stats inside each submit step.
