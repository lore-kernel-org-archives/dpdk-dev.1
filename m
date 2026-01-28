Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E4D46C06
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68918402B6;
	Wed, 28 Jan 2026 22:45:57 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D0713402A7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:45:55 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so175022f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769636755;
 x=1770241555; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTZJ+0x9KCp4LPZYQ70NfWnHWamta8iDJLUhqbr192c=;
 b=PX9tuGuBE//1BgpNziJvGo6v08tpFisWIKJkJf94bTqzgYxydaoLjADUgS90xUKo7o
 URshSQhOamghZJ2B4hOhn2Uy3rXvRrFpN0Bp5nxJI57DtpT8CEjMk54xZPaimwa4pUhg
 IZCcgRS1lEoAohoQ2bsX8UQ7kJk1UjIAOyfYzSah4GsES1N7AjIXYhRHA83hONvEMloY
 n2ty8b3zTDaxW6P8nLA0l2d437G1mC72ppPfOCmGhkciw8WwHqYUdcjJNcV63BUCGrD+
 RHwolCLAx6ethaLfuuffPQtXdfhP1tXRhgLgexQFs/3gUzk2V52247NVHz7AvsD610aJ
 jjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769636755; x=1770241555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fTZJ+0x9KCp4LPZYQ70NfWnHWamta8iDJLUhqbr192c=;
 b=ubBcAY9jKu9QFcpEKuGNBXdctcRt7skqm1AEEzmQupkaJOsXzClJmMuGZzUXjGcHTA
 x53E0LDneyp4qZjs53K+9JpYTZZ4VKPYx16FIEoukda6LTiNM92qYJnYM5cXwOgT8pX+
 1Xbfnqh6fVR+O8VFC1klHXDAGu58BUdHdqSOz+VoahXzAyYIPSce1hBR2WkYyQ0Vz2yY
 D0piC2WH2fvx42fGHexokG7KQDBYakypSosHX8tXlbMAhd+gDkjHsFBv+xYzhkLjTtpD
 0VB6Aqt6tgPcfV7VzSVLHJ2lRkPEF7KRgeIKpD1bFDbZB/I3+873Qgy1wHbZvOY/PveY
 PJsQ==
X-Gm-Message-State: AOJu0YyyEX0Hcy/zB06qxI2g31XxUb+WzZ+I4twJZ4dxaQONlo13krJN
 3pEmctQ8gVe6oouBX4MOfhpCK8hhCKulcuzKbGWiU6QpuL0aZ6YeO3D4HY6hrUzG6FA=
X-Gm-Gg: AZuq6aLu7m7b2QC17hUkVIPWlj3jN79200t/ZVfknNZSMOTLS8fshtCSExPWtZPKAYL
 6B2gCkE6AFK/wlGDTo1lFjqmkgHQySm+zBYj5eYvCiJpI9hSwM1Q5vEBW0VWAE3y4fe7TmZyQ3I
 corBMy4qKBDLhk/rmFIda3bgKXNCsbWKC1lzltqGdK4B10Y2o/Z/y2JoLwMVnlE/LGMjRS/8TMR
 IigTJ3LbY0hOQlcGSNmpaeJWKHMYdl08tcfNiCUed6imw5it3yzMgs88xwFIG7JA3jjcfA2+clz
 CqyBVmlGOziDnFjrnnfelztO80MqtDxwIPJDstF/Thlkml0Bpeh6n0b6cgvEXsOp4HTgg6j6H6V
 8Be95uNXDJpvO02T+uRKTcsoyviZb8Acj1gF8+NQUZ0n8EslTwEkyZFAZXCjeLk9MkRFTICE45K
 5p9JxE/4x/kJd2eVTxTa72SYQDd580U5mDVA+qO4qaYfboeCCWHGig
X-Received: by 2002:a05:6000:40cd:b0:435:bbde:e050 with SMTP id
 ffacd0b85a97d-435dd1cd80cmr9194731f8f.52.1769636755017; 
 Wed, 28 Jan 2026 13:45:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4824sm10482476f8f.1.2026.01.28.13.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:45:54 -0800 (PST)
Date: Wed, 28 Jan 2026 13:45:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 2/4] test: add test for af_packet
Message-ID: <20260128134548.7d228aa2@phoenix.local>
In-Reply-To: <CAFn2buC-6sMuhiWRp-OmSR5HvGrhNRs+erqc=qZpWvqQ26GDPg@mail.gmail.com>
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-3-stephen@networkplumber.org>
 <CAFn2buC-6sMuhiWRp-OmSR5HvGrhNRs+erqc=qZpWvqQ26GDPg@mail.gmail.com>
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

On Wed, 28 Jan 2026 12:36:41 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Awesome! Some suggestions below but could easily be done in a followup
> for incremental progress.
> 
> > +       /* TX burst */
> > +       nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
> > +
> > +       /* Free any unsent mbufs */
> > +       for (i = nb_tx; i < BURST_SIZE; i++)
> > +               rte_pktmbuf_free(bufs[i]);
> > +
> > +       /* Small delay to allow stats update */
> > +       rte_delay_us_block(1000);  
> 
> Consider polling rte_eth_stats_get at a more frequent interval, break
> when you see status update, and apply overall timeout/repeat limit ->
> can make test more reliable and take less time when data is usually
> available quickly
> 
> > +       /* Try to receive packets (non-blocking) */
> > +       nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
> > +
> > +       /* Free any received mbufs */
> > +       for (i = 0; i < nb_rx; i++)
> > +               rte_pktmbuf_free(bufs[i]);
> > +
> > +       /* RX from tap interface without external traffic will return 0 */
> > +       /* This test just verifies the RX path doesn't crash */  
> 
> Consider adding a test that round trips data (tx -> rx) to exercise
> the read loop.
> 
> > +       /* Get current MTU */
> > +       ret = rte_eth_dev_get_mtu(port_id, &mtu);
> > +       TEST_ASSERT(ret == 0, "Failed to get MTU");
> > +
> > +       /* Try to set a smaller MTU */
> > +       ret = rte_eth_dev_set_mtu(port_id, 1400);  
> 
> Consider getting the min/max supported MTU and setting it to verify it
> works. My patch fixed some issues related to MTU and overhead of
> frames that may have been caught by this.
> 
> > +
> > +       /* Reset stats */
> > +       ret = rte_eth_stats_reset(port_id);
> > +       TEST_ASSERT(ret == 0, "Failed to reset stats");  
> 
> Consider enhancing to introduce multiple threads (writer and reader)
> to replicate
> 
> > +static int
> > +test_af_packet_multi_queue(void)  
> 
> Consider sharing rx/tx logic in common functions for single/multi-queue cases.

Wow, AI could take that feedback and revise for a new version.
