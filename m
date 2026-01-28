Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED6FD46BFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 20:36:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FED7402CE;
	Wed, 28 Jan 2026 21:36:54 +0100 (CET)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) by mails.dpdk.org (Postfix) with ESMTP id D4838402B6
 for <dev@dpdk.org>; Wed, 28 Jan 2026 21:36:53 +0100 (CET)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-5eea31b5cb7so110587137.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769632613; cv=none;
 d=google.com; s=arc-20240605;
 b=iJ/4uYycU5YDCMN/aUhV3Ckx5Am4O39T0+5KBwmFS1ld4OO6pMaRCoKpVxnQu64CMK
 BeljXWkOlMLxYq3p7hvbYh5kaE+aQdJGUpNFJAhnwJuvDW+OC4A5NwkRYrPAC8Z+kFX8
 OAZeNrvjBx6ARNCUl58YsT/U2VAniyoufWq11hNtJ2rW/eId7dBzzYCQ8xcwdPYcIjxb
 txMIvQQhOKrI3zvF1YBP5cuyZk+S1JNpSaCueiUHonO6IhrDKr3yXmezEmMjHr1auEma
 IEa7uMMzUNYyRFI8cMsyTwVIPq5p4kfLgXGcpEmnPxi4cCAhsaccJBHqLg2NrX8sWKKo
 uuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YenUkh4idglQwTAeECxnZQ6psi7ajX61aLll6TQ/Ytw=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=PuGpuVc20jkyOtnAu2J/6etaK0Y5Pn7bBJanxURCKs44EGdtPPFc09fjQGb06wx5Oa
 xb4L9A+VhHtPnE2rpzK/64zWVFFVWJuWHonxxgrwmRh5BlugYCGscbEVXwAhizNT0FQB
 4m+iRo1bZvLeYj/zXh9uOQo7JHKmFo614HLqh4C7fkQvW697ZbmMNYtk8zTL0tzNyw1t
 Jc4dUsEnZ1Cih/FxYHa6Bh1sHpmW7Fb0qJ7HfCkW3BqWons0wDkUu9sWZTn+CjZjFQVQ
 k745XqtyKCMF5cpi892dZyx+irujv71uFEoSXGwUgGO4d+xip4mnRfq0UOBMTZhZGuBJ
 7TJw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769632613; x=1770237413; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YenUkh4idglQwTAeECxnZQ6psi7ajX61aLll6TQ/Ytw=;
 b=HTcbF2axb1LpKcliR3L7aJLHNaDsF6szdeDhaLlgM9FtpMq4Nq4Br+kx7nsJaLApM+
 n+ruGccZNHezqJM3VRpd9QHdvIVBoVUbh9vaFJdgmS10y/HCRz+j3uRd/BXEmFE7kOSU
 ca95G8n9PhUo1oj7tW7rT2J3iJ/zwT2655AeVWX6EcTTu7ss9sqLBep6Xdl/wWo/Mrob
 8UbivUoCtTvZAIfbia7HTGKlmaYE9uxpJN0UleHKlA8qzh7zKNpxwToYZEZR4nOVR+/4
 NCjNM8HbLXrJrGWZqmsml8HfWMVz5k17Z8WFal3YzCxWgy0F05vrWFsOONTTADl6nTUM
 Qhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769632613; x=1770237413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YenUkh4idglQwTAeECxnZQ6psi7ajX61aLll6TQ/Ytw=;
 b=lo5x2jJVdrgg15SGADqRzdnmsO2Ye64TgtOmdr0vx9o1gwxuLQjDBssa5aUHnPqPb0
 EE2e69zl3j0ob3Er6cChnGZYCycWIbrE0kGvwPDiiHbpFpAVPqFpV2beRGKfgViVKwXb
 dqwbtdFuEBjmfQQCrC485KXsDFLHGzpmS7WR7FP/Yi/O8WZGKzVtWTFDj0moulsiE1vi
 r6pz9UyF/2Z18NDMmtW6bo8ZlWRst9H4sg1Jr4z9AI8VSxMYTC2/u9Hx1slW7P6xJ82V
 0NHWRIy3jORLVV4Ay81wbX8sF5OXDfrNtWwhwnl0qf3JPfnFClZtgI1Ta5oleCl0dkK3
 sqsg==
X-Gm-Message-State: AOJu0Yy2wrVDh1e7PdNQobAK+BLW4GZ4mbyL1Pu4Uht8GBlBPzcQQ3nh
 R1yXbAfk/yUMFRXgMFUiolJ6xbFs6w5zBlRdH3s2GCGZBs1DYhJhePk+c9IUSgvaTiV8tBKEgBD
 YxNyC85yTMCEQGwTgmmcBOy8iLtL0x3g=
X-Gm-Gg: AZuq6aKipQMqzwKOQQ5evwZzERNpxMTUolHLyrm5xj5QpNN9ctjIFQlz3LhlSeGmDSn
 QlfAbD4wnL/EdnN+TrYGGIKbqvnLfxcVugAjFR6maqEc7bVLLrRDarFNej6s+sghkky6S13QM9I
 rekJV0wg/qag314HeN485Q2AE7WBv1sNogxcVKPP8Dc+GZ+f8maLdNF8ioXRaCvu9xDsCetFD23
 j+uTS/PlyCYrwkNLWgWcIDWk2RWbDaAEaACiMHvmL6FFyq4kdh27yqgcLugfANhBgCCdQGZUZW+
 36gOP7Idu/87DTR06EoYLyE=
X-Received: by 2002:a05:6102:948:b0:5f1:72a7:f879 with SMTP id
 ada2fe7eead31-5f72378e7a1mr2305399137.28.1769632612895; Wed, 28 Jan 2026
 12:36:52 -0800 (PST)
MIME-Version: 1.0
References: <20260128173138.151837-1-stephen@networkplumber.org>
 <20260128173138.151837-3-stephen@networkplumber.org>
In-Reply-To: <20260128173138.151837-3-stephen@networkplumber.org>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 12:36:41 -0800
X-Gm-Features: AZwV_QjkaJpXSR-UcoeabgLYDDThuc1UvT2T-uN6PuG0my5QAOtAufdlVJOKjJ0
Message-ID: <CAFn2buC-6sMuhiWRp-OmSR5HvGrhNRs+erqc=qZpWvqQ26GDPg@mail.gmail.com>
Subject: Re: [RFC 2/4] test: add test for af_packet
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Awesome! Some suggestions below but could easily be done in a followup
for incremental progress.

> +       /* TX burst */
> +       nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
> +
> +       /* Free any unsent mbufs */
> +       for (i = nb_tx; i < BURST_SIZE; i++)
> +               rte_pktmbuf_free(bufs[i]);
> +
> +       /* Small delay to allow stats update */
> +       rte_delay_us_block(1000);

Consider polling rte_eth_stats_get at a more frequent interval, break
when you see status update, and apply overall timeout/repeat limit ->
can make test more reliable and take less time when data is usually
available quickly

> +       /* Try to receive packets (non-blocking) */
> +       nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
> +
> +       /* Free any received mbufs */
> +       for (i = 0; i < nb_rx; i++)
> +               rte_pktmbuf_free(bufs[i]);
> +
> +       /* RX from tap interface without external traffic will return 0 */
> +       /* This test just verifies the RX path doesn't crash */

Consider adding a test that round trips data (tx -> rx) to exercise
the read loop.

> +       /* Get current MTU */
> +       ret = rte_eth_dev_get_mtu(port_id, &mtu);
> +       TEST_ASSERT(ret == 0, "Failed to get MTU");
> +
> +       /* Try to set a smaller MTU */
> +       ret = rte_eth_dev_set_mtu(port_id, 1400);

Consider getting the min/max supported MTU and setting it to verify it
works. My patch fixed some issues related to MTU and overhead of
frames that may have been caught by this.

> +
> +       /* Reset stats */
> +       ret = rte_eth_stats_reset(port_id);
> +       TEST_ASSERT(ret == 0, "Failed to reset stats");

Consider enhancing to introduce multiple threads (writer and reader)
to replicate

> +static int
> +test_af_packet_multi_queue(void)

Consider sharing rx/tx logic in common functions for single/multi-queue cases.
