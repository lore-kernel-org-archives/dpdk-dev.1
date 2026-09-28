Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A1BCA5FA2
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 18:30:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8297840E37;
	Mon, 28 Sep 2026 20:30:46 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 564B140275
 for <dev@dpdk.org>; Mon, 28 Sep 2026 20:30:44 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88206fc44c6so1862458b3a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790620243;
 x=1791225043; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dbvCDjRwoqYcwF0ZNJGPz/53o6NlOrt/TKoXwvw/ohQ=;
 b=vxYECvbN8vcwTGbL/s6zRXz+ASJWMGG1BTKzk86EQa2bt18NORGHxxAujisKRzQ299
 Pg8uFWqF81BX/Ej5eg7Sz56NltyHCkM3kifhoPOPKTEFEcOZXIbLOy6UgRgobzxYBpda
 oAS+aYJ64d2U4PAf8W3gRJL+BWuTigYWX2RDm0KQRpKDlwFsSszNVWmqWcbYVoX/p9iq
 HdDycbwlYU9ryUZUen79+Lq1YS5oT8y4nO36poIpSjH2KXTuP98UTzoW/AhEv+PO3xjl
 Pfyp8ikudAATVWCrYlT5r3KrXnMIREOeMfBmCpBdhfvQgNPIO4pHx6tVtTpFGCGGuyYf
 tzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790620243; x=1791225043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dbvCDjRwoqYcwF0ZNJGPz/53o6NlOrt/TKoXwvw/ohQ=;
 b=auyHJ30Pb7IWHEEGhJoPmAcK6WxZOE1bdQ0CW9cq8VSPDTGha0T9EMX8DTyHd+Fuyk
 U7FUjQtIZQx/C+n143opZlv4tPwzfr5ha2GZ6zKnsHH2NV461vtRX+pPWt/nvk3yNpFc
 a2anXs3OFAgQJEvvWtBQ6wh99F7ok8Tzb023qW7WnrOuL0RgQ++Y0qnxYZnT5kBrbpzz
 EHMtcWC9SCv29Tazlo6ySMpseiYzqHj1TcGiT+9JgNIrMe8mYss7uovPYfobeEFEiJCz
 5+u9oBwG3r8mcz3dJKtd5B4jBEjI06e72b3M9iddY3oeAftESNRKejagW6Wgze1214NC
 0pDg==
X-Gm-Message-State: AFuF++kTZyhY6nTr/PXYgIExH79YiDUucqqZy1ND77QMfj2XYOUftDan
 mOZty7W//6pOolWiCBUYydhp565x76TFc9Tk0g79rjtlWdHg+A/0v58RBpZXBFCcPTM=
X-Gm-Gg: AYBFou2iEHQk8/6jZVi6zFP6uRZRPsQDRgJNA+dtEGTKDlafpgu87KKvfvJei2LKMVG
 OfRHFEG/vUymYFHkfCBCsxtDo8L4w8Bj6Ahk8IMxDokQgD6gEXCuf8gz0UELksxDk341g5js0pc
 wr3te5LGAy+rE6EeIqPJCu6n5eHSaWitkcXcN6iV4wIYH8kN8giea6jrkgTWEuhkB5njMzNHxRD
 mrQeNls2E9Hhf+CHkB6/5VRkfPZ2KEvHQTXOSBUiGqdrFGbxFZHB++X7PIzPpLcnhqq3BKKn8ZO
 nGLe23IeV8ghaj8YTGPtO1WpGM78UMXn0+ZmD0RIg13eWQwaHtdu0pd3BdFt2fg3YDAvYkLDSQe
 dCd4LxHatM+X0nvDFG9Ph2F+5h9gie9c4RIEw2CXU9E+0y62pdF7yimgzIONA4vhXqKNKABpin1
 en3ZBpalT1eEfsGYuQFxdtJtZiwceH5F2pIGXhRxw2jI8G6wiyYjisTIsO26XK6TUZ6YqlHhrd2
 ircjdrkqEfo///wAjTOwsWoXCcBllba84ENbi4F
X-Received: by 2002:a05:6a00:2e11:b0:882:157d:95d2 with SMTP id
 d2e1a72fcca58-882157da507mr4768467b3a.8.1790620243009; 
 Mon, 28 Sep 2026 11:30:43 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8825ecac8absm2336512b3a.56.2026.09.28.11.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:30:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:30:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, stable@dpdk.org, Leon Yu <leon.yu@nebula-matrix.com>, Sam
 Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: allow MTU change when port is started
Message-ID: <20260928113041.0f5e5f4d@phoenix.local>
In-Reply-To: <20260928083616.118559-2-dimon.zhao@nebula-matrix.com>
References: <20260928083616.118559-1-dimon.zhao@nebula-matrix.com>
 <20260928083616.118559-2-dimon.zhao@nebula-matrix.com>
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

On Mon, 28 Sep 2026 01:36:16 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Remove the dev_started check in nbl_mtu_set() to allow MTU
> configuration while the port is started.
> 
> Fixes: 75cdda36a4c5 ("net/nbl: support MTU update")
> Cc: stable@dpdk.org
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

I don't think this is safe. AI explains in more wordy detail

Review: [PATCH v1 1/1] net/nbl: allow MTU change when port is started

The PMD Rx buffers survive a live MTU change. nbl_res_alloc_rx_bufs()
and nbl_fill_rx_ring() post every descriptor with the full mbuf data
room, not an MTU-derived length, and nbl_res_txrx_recv_pkts() always
chains on num_buffers from the Rx extension header. In-flight
descriptors cannot be overrun by a larger MTU; oversize frames get
chained. What the patch drops without replacement is the scatter
contract with the application, and nothing shows the hardware side
of the MTU change is safe with queues running.

Error
-----

nbl_dev.c: nbl_mtu_set()

With the dev_started check gone, a running port accepts an MTU whose
frame no longer fits in one Rx buffer. scattered_rx is computed only
in nbl_res_alloc_rx_bufs() at dev_start. An application started with
MTU 1500, 2K mbufs and no RTE_ETH_RX_OFFLOAD_SCATTER can call
rte_eth_dev_set_mtu(port, 9000); the call succeeds, scattered_rx
stays 0, and the Rx burst starts returning multi-segment mbufs the
application never agreed to handle.

Replace the removed check with the one ixgbe_dev_mtu_set() uses:
refuse, on a started port, a frame size that needs scatter when
scatter is not already in use. NBL_ETH_OVERHEAD already covers two
VLAN tags, but the Rx extension header occupies the start of the
first buffer and must be counted, as nbl_res_alloc_rx_bufs() does:

	if (dev_data->dev_started && !dev_data->scattered_rx &&
	    frame_size + <rx exthdr len> >
	    dev_data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM)
		return -EINVAL;

Warning
-------

Commit message

The PMD does not program MTU itself. nbl_disp_chan_set_mtu_req()
sends NBL_CHAN_MSG_MTU_SET to the kernel driver over the mailbox,
and the Rx queues are not quiesced around it. 75cdda36a4c5 blocked
this on a started port deliberately. The message needs to state what
MTU_SET changes in hardware (ingress length check only, or anything
in queue context), that frames in DMA while the limit changes are
handled, and that it was tested with the MTU raised and lowered
under traffic.

Fixes: / Cc: stable@dpdk.org

Returning -EBUSY on a started port is documented behaviour of
rte_eth_dev_set_mtu(), so the old code was not a bug. This adds a
capability. Drop both tags; changing MTU semantics in the 25.11 LTS
is not a backport.

nbl_dev.c: nbl_mtu_set(), unchanged context

	dev_data->dev_conf.rxmode.mtu = frame_size;

rxmode.mtu is an L3 MTU; this stores mtu + NBL_ETH_OVERHEAD. The
value is returned by rte_eth_dev_conf_get(), so a conf_get then
rte_eth_dev_configure() round trip grows the MTU by 26 bytes each
cycle until max_mtu validation fails. It is also written before
set_mtu and not restored on failure. ethdev updates data->mtu on
success; delete the assignment. This one is a real bug: send it as
a separate patch ahead of this one, with Fixes: 75cdda36a4c5 and
Cc: stable@dpdk.org.

Info
----

Configured MTU never reaches hardware (pre-existing)

rte_eth_dev_configure() sets data->mtu from rxmode.mtu without
calling mtu_set, and nbl_dev_port_start()/nbl_dev_txrx_start() never
call disp_ops->set_mtu. An MTU requested at configure time takes
effect only if the application also calls rte_eth_dev_set_mtu().
dev_start should push data->mtu to hardware. Separate patch.
