Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9026D19512
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 01:02:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3318140A77;
	Tue, 27 Jan 2026 02:02:30 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 08F9C402C1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 02:02:29 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so46218165e9.2
 for <dev@dpdk.org>; Mon, 26 Jan 2026 17:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769475748;
 x=1770080548; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kf7BrmnSHgu+ddV/fzTiuWuszSBIvdKi2R0JG3Od0/8=;
 b=Wbx7jVW3zTMKWlLWcnivnDjeEkU4Dm5iCL7cq+XPh1aD/1nu480sD5J/Ogs2JIamX3
 8b0Yzr90X6yphOF4LSqqdF7rilzjeSI+NbMFNEvUP2Z7k09+ikKjps75/fZ7R6tNp4QE
 AcW2tKvz8sxFR8w2UwL7HgVqrK1Pw1YEXLUwN72blyrunX9wIcfAx8BF+U/7Vpt0LuJj
 rrT4gyEJ8JSfPAK/kq/Rtq4i0FQZTOFSCepFLdMvXlIw5EP60UyEui1w2hacM2jY9uQ2
 F6RSKYEJCjLIRmmm7ts81w+Xp0lNrJABZ36kx1Eg0V5+mRoq2B/NQkH3XAP+/dJDn1bG
 70KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769475748; x=1770080548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kf7BrmnSHgu+ddV/fzTiuWuszSBIvdKi2R0JG3Od0/8=;
 b=ld5xYajCmajGTZdmb15E0ci5EwmcyDMeRSZ090oJQqCbe4TtRtrbMhfU7P7iRjN4d9
 OY1GpJualn09fCaVCAmY7zpX8ujlnvXIplbhcX1nqzhrBA0Ol9ObVUUvJWJHCkXAmtOo
 UMtjgxleMPldbqsgmO/7HwTO5DG0CiE0G9qBSbBQw2GcANzs2QSOD++9yctapV6+WfyO
 MHtQys9DYe7rDnsog1ALUZlo9rxW2R97CoTHrB4inoNFyCS1adP6lE3ZBSE1GYmzzDe3
 sWfeLoaxGvQm+obrRokBSTFR+Lnbds+Q/PsL2vgqzQmsOfX/IffNB1zPf9Gr5kNVj/hv
 d75Q==
X-Gm-Message-State: AOJu0YwB+mb6I0WXw83j0RuZnsVW+LhmLYWz42c5qU6GeTaKIx0hYD1X
 lKonULHpno+AnQptlEEsHWctbBNa8cQk3pg64oPI6N48oscDEtJKz4gy9n1Hj5EX2kqOpneFh5D
 t3L2o
X-Gm-Gg: AZuq6aIxTUIiLiX8J70iBvoQZw1kCI4vrVUNX7qKvDL7tEul510xFNhs0j5+WkluZXs
 QaqepkD1L6gWDtHu5Hvo2ieYDFyIx0A5HemBME0oZvaMzqorS2bVc2dZZY88Vc1QTY5qeWvX2U0
 RKt3bmjV2HFIvdk1AD4c4/whnO7vpmxkePJJy3JnlJtf1HkXV81r+BBgY3up0zWSm+QysVyFqPv
 jYbdKn0XBka7ksJ6hWLJSRFY0QUfO5v4XHqvX4d3BeedJd9C7VtRuSptapfcmr9qzrQpck90vE+
 Ui3T4oDc96Gp995GQVlAy+c+/P/QNVFLmt/WfvAFBdwvQ7PFp1WsCF85T9J0qGfuhzYcYoMgZli
 yzLcgt/YkuheK1zfRKVZDMnHp/rMpn/2Xx+yKyqnTGrQbZiGOl7V2Yuivl129Z15y1b1cnp7uQh
 kW1ooTpxv1wOHBkkClqhhRZkozfzNHKVW7y1PmuyQPZY4TA2tf7aDG
X-Received: by 2002:a05:600c:458a:b0:47b:e2a9:2bd7 with SMTP id
 5b1f17b1804b1-48069c6970fmr91035e9.19.1769475748487; 
 Mon, 26 Jan 2026 17:02:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804dbbcbddsm112119655e9.15.2026.01.26.17.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 17:02:28 -0800 (PST)
Date: Mon, 26 Jan 2026 17:02:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon
 Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v2 1/4] net/nbl: fix memzone leak in queue release
Message-ID: <20260126170222.6ca4c05c@phoenix.local>
In-Reply-To: <20260126075815.178216-2-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
 <20260126075815.178216-1-dimon.zhao@nebula-matrix.com>
 <20260126075815.178216-2-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sun, 25 Jan 2026 23:58:12 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/n=
bl_txrx.c
> index 650790b4fc..563f011cd3 100644
> --- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
> +++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
> @@ -69,9 +69,10 @@ static void nbl_res_txrx_release_tx_ring(void *priv, u=
16 queue_idx)
>  	struct nbl_resource_mgt *res_mgt =3D (struct nbl_resource_mgt *)priv;
>  	struct nbl_txrx_mgt *txrx_mgt =3D NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
>  	struct nbl_res_tx_ring *tx_ring =3D NBL_RES_MGT_TO_TX_RING(res_mgt, que=
ue_idx);
> -	if (!tx_ring)
> -		return;
> +

Automated patch review spotted this removal as possible problem.

Code Review:

ERROR: NULL pointer dereference introduced

The NULL check for tx_ring was removed but the code immediately dereference=
s it:
c

static void nbl_res_txrx_release_tx_ring(void *priv, u16 queue_idx)
{
	struct nbl_resource_mgt *res_mgt =3D (struct nbl_resource_mgt *)priv;
	struct nbl_txrx_mgt *txrx_mgt =3D NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
	struct nbl_res_tx_ring *tx_ring =3D NBL_RES_MGT_TO_TX_RING(res_mgt, queue_=
idx);

	rte_free(tx_ring->tx_entry);  /* <-- crash if tx_ring is NULL */

The old code had:
c

	if (!tx_ring)
		return;

This guard must be restored, or the callers must guarantee tx_ring is never=
 NULL.

Similarly for nbl_res_txrx_release_rx_ring =E2=80=94 no NULL check before d=
ereferencing rx_ring->rx_entry and rx_ring->desc_mz.



Further AI lead analysis show scenarios where it could be a problem.

Complete Call Chain Analysis for Patch 1/4
Call Flow

DPDK Application
    =E2=86=93
rte_eth_dev_tx_queue_release() or eth_dev_ops->tx_queue_release
    =E2=86=93
nbl_tx_queues_release() [nbl_dev.c:420]
    =E2=86=93
disp_ops->release_tx_ring() =E2=86=92 nbl_disp_release_tx_ring() [nbl_dispa=
tch.c:163]
    =E2=86=93
res_ops->release_tx_ring() =E2=86=92 nbl_res_txrx_release_tx_ring() [nbl_tx=
rx.c]

Where tx_ring Can Be NULL

The macro definition:
c

#define NBL_RES_MGT_TO_TX_RING(res_mgt, index)	\
    (NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->tx_rings[(index)])

Where tx_rings is:
c

struct nbl_res_tx_ring **tx_rings;  // Array of pointers

Scenario 1: Normal close without all queues set up

In nbl_dev_port_close() =E2=86=92 nbl_release_queues() (line 337-349):
c

for (i =3D 0; i < eth_dev->data->nb_tx_queues; i++)
    disp_ops->release_tx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);

If the application configured 4 queues but only called tx_queue_setup() on =
2 of them, tx_rings[2] and tx_rings[3] will be NULL.

Scenario 2: DPDK ethdev layer calling release on never-setup queue

DPDK's rte_eth_dev_close() can call tx_queue_release for all configured que=
ues without validating they were set up.

Scenario 3: Re-setup path mismatch

In the patched nbl_res_txrx_start_tx_ring():
c

if (eth_dev->data->tx_queues[param->queue_idx] !=3D NULL) {
    NBL_LOG(WARNING, "re-setup an already allocated tx queue");
    nbl_res_txrx_release_tx_ring(priv, param->queue_idx);  // <-- Called

The check is on eth_dev->data->tx_queues[] (ethdev layer), but tx_rings[] (=
resource layer) could differ if a previous setup partially failed.
Verdict: Confirmed Bug in Patch 1/4

The removal of NULL checks causes NULL pointer dereference in both nbl_res_=
txrx_release_tx_ring() and nbl_res_txrx_release_rx_ring().
Required Fix
c

static void nbl_res_txrx_release_tx_ring(void *priv, u16 queue_idx)
{
    struct nbl_resource_mgt *res_mgt =3D (struct nbl_resource_mgt *)priv;
    struct nbl_txrx_mgt *txrx_mgt =3D NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
    struct nbl_res_tx_ring *tx_ring =3D NBL_RES_MGT_TO_TX_RING(res_mgt, que=
ue_idx);

+   if (!tx_ring)
+       return;
+
    rte_free(tx_ring->tx_entry);
    rte_memzone_free(tx_ring->net_hdr_mz);
    rte_memzone_free(tx_ring->desc_mz);
    rte_free(tx_ring);
    txrx_mgt->tx_rings[queue_idx] =3D NULL;
}

static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
{
    struct nbl_resource_mgt *res_mgt =3D (struct nbl_resource_mgt *)priv;
    struct nbl_txrx_mgt *txrx_mgt =3D NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
    struct nbl_res_rx_ring *rx_ring =3D NBL_RES_MGT_TO_RX_RING(res_mgt, que=
ue_idx);

+   if (!rx_ring)
+       return;
+
    rte_free(rx_ring->rx_entry);
    rte_memzone_free(rx_ring->desc_mz);
    rte_free(rx_ring);
    txrx_mgt->rx_rings[queue_idx] =3D NULL;
}

The memzone leak fix itself is correct and needed =E2=80=94 but the defensi=
ve NULL checks must be preserved.

Conclusion put the null checks back into rx and tx and retest/resubmit new =
version.


Full chat is here if you are interested: https://claude.ai/share/d543bddd-7=
406-4f00-b5cb-4a92e8718476

