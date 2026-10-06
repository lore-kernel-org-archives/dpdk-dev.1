Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE339CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 13:41:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A72D4402B0;
	Tue,  6 Oct 2026 15:41:23 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id BE2074025A
 for <dev@dpdk.org>; Tue,  6 Oct 2026 15:41:22 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2e4a341d177so16643025ad.0
 for <dev@dpdk.org>; Tue, 06 Oct 2026 06:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791294081;
 x=1791898881; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EjVrpNHpGqRAhubHWMEM7ZXtNGavedC1l6b4SzxLhqk=;
 b=okfcBFsgDl7vxTdmyUYXyn2rVEX9G14HJazzvX2xm2AZO6N/8GaS4YmFjX8/vMFM8O
 LBfluDmzUyiy97xEXzgAePhE15RRgWJ8A89w2HdSxsZu7GxjP48RmVbISEXynnrct/ig
 FuOGwPlkHJfKRkFaKEIyL+5hIJ6Ug85/CmPLqKgYblEIpPTfX1xRhTg1XzD4zyoYkkUU
 fsZF7HXIakqoNxhkQIhNrbvk+TMEbko1wFLqBDwgHQ7xrN/o0qY/dGCI+BJi2ftUsIz1
 8IL018bBRvLJrL4JUAMHBvQf9PCFw8wJjnTMg+rKxD1H4dHbwtR3wIECLdRZFMA1Wv5o
 lD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791294081; x=1791898881;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EjVrpNHpGqRAhubHWMEM7ZXtNGavedC1l6b4SzxLhqk=;
 b=mIK/9c0gxKDKpPnc4tQ76wIpSqPqtSyhJDluyKIT3POTnGdVB9xbLLb+lZuyGyfwxn
 HyMbgqLH7eTinVtdAhzVfU7jp4iyOlBT3fozAWYBekjHosk+KJeLPjkcBNerUIQETb4l
 mRu8q9hFnwjwpE8iCyERK5RvKK1g+S6eKILLDvrFkoL8bvGcldMqdyVtsmyJxiTXnFQ9
 Pv8wI8xDw7hL5EMGT5SmbFbqTdGkYBxIT/6bRMm+SWAP0uaklFXHO/iXsQNfE/wmsl7Q
 4Tcz0lxwzjgff/6hN4r2yXu0g3LyeotnzyLrdzwqXnNgqWaEVELf/s/JfgSdBohXFjT2
 hKWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPJvxvEngM6UUIP/URZtm9YvCBPvgeRBCUIHyeiM4GC3yfwyW3sT29HhzvDvNs/TfSCT4=@dpdk.org
X-Gm-Message-State: AFq9FYJEFi1I4dIje51iCb6mRltzmZHwv8I/BqA4nWknAoddggwmLNKI
 13NGVeODoISZjhcCmbPKIXeKMeLd2ms7mgAgS5MWZA9I532xxkfBWSXfQh0lT2cyCUyaUJm05sT
 pqAS/5BM=
X-Gm-Gg: AYBFou0d/u0wyDg/L+iaZBLhk0GldtkMjtRUG109fdsilcRy2PBUXwv/RZRZsY/5WAJ
 aSm+uu2HuLN6nKLuVzHQw8pN7oHR4YrKNb+J36dFpam5WiT/cpTgeHwvnp4xYdl90LbEmlrWgaN
 2vOkIs273125b9j+Gm4Kdk7yRzLH5KCQalxNgnHax9XUygTobgYzZijJUR7TKlGI4t+juWfKVZC
 OPjsEpDmzOTMmsADb/q5nQDugzE7AENF5+Gf+VqJcm6MquH1GzUtbjObFcLNhK0fh1OHD6bFn+K
 9j089oRk2f5I1X1IWxqPHH7/3Mk107LoI34qe3icVR6PEM+ITRcH3dK5FQbdB0s58/+5V2Ev7Co
 JjhHjA9n8eIZuhnhnS4tHtX4i5wdVcXTU37mUMj/iKn6k2I3O+PGtjG/Pi+3FfwqZn31wcIQn/H
 9csHHWn08Npr7GNP3O5nkY+dyOHDOy1JHM+SfKwYBhZSSIdgpUk4/9VyVu3MfJKxnxsT3aEbSh0
 NuZ8OP+mlvAVcCTqeGagn9xadSGeBUc+uUQcbevvwfWO60v9r0=
X-Received: by 2002:a17:903:46cb:b0:2e3:cac:3870 with SMTP id
 d9443c01a7336-2e5dcdb9690mr10694875ad.40.1791294081416; 
 Tue, 06 Oct 2026 06:41:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5eb382asm22573755ad.32.2026.10.06.06.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:41:20 -0700 (PDT)
Date: Tue, 6 Oct 2026 06:41:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: Thomas Monjalon <thomas@monjalon.net>, dev@dpdk.org
Subject: Re: [PATCH v3] net/af_packet: add option to ignore outgoing packets
Message-ID: <20261006064117.3cdab400@phoenix.local>
In-Reply-To: <20261006064228.130545-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261006064228.130545-1-frank@dressler.pro>
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

On Tue,  6 Oct 2026 07:42:28 +0100
Frank Dressler <frank@dressler.pro> wrote:

> By default, AF_PACKET delivers both incoming and outgoing packets.
> This might surprise applications that expect rte_eth_rx_burst() to
> return only incoming traffic.
> 
> This patch adds the devarg ignore_outgoing=<0|1> to enable
> PACKET_IGNORE_OUTGOING. When set, the kernel drops outgoing frames.
> The default is 0 to keep the existing behavior.
> 
> Signed-off-by: Frank Dressler <frank@dressler.pro>
> ---
> v3:
> - drop #ifdef PACKET_IGNORE_OUTGOING (uapi since 4.20; DPDK requires kernel >= 5.4)
> - fail the test if ignore_outgoing=1 cannot create a port
> - drop kernel >= 4.20 notes from docs and release notes
> v2:
> - use PACKET_IGNORE_OUTGOING / ignore_outgoing= instead of capture_dir
> 
> ---

AI spotted issue with multiple qpairs.

[PATCH v3] net/af_packet: add option to ignore outgoing packets

Builds clean with -Dwerror=true. Test not run.

Error

1. ignore_outgoing=1 has no effect when qpairs > 1.

     rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
                     &ignore_outgoing, sizeof(ignore_outgoing));

   With more than one queue every socket joins a fanout group.
   fanout_add() removes the socket's own packet_type from ptype_all
   and registers the group's instead, and dev_queue_xmit_nit() only
   looks at the group's ignore_outgoing. The per-socket option is
   accepted and silently does nothing. The group needs
   PACKET_FANOUT_FLAG_IGNORE_OUTGOING (6.2) or'd into the flags half
   of fanout_arg.

   Kernels before 6.2 do not validate fanout flags; the bit is
   accepted and ignored there. Either keep the sll_pkttype check in
   eth_af_packet_rx() as a backstop, or document that
   ignore_outgoing with qpairs > 1 needs 6.2. Distro headers older
   than 6.2 lack the define, so provide a fallback #define.

Warning

2. Test only covers the single queue case and never sends an
   incoming frame.

     TEST_ASSERT(rx_on == 0, "Expected no packets with ignore_outgoing=1");

   A port that receives nothing at all passes this. Write frames to
   tap_fd as test_af_packet_loopback() does and check that the
   ignore_outgoing=1 port still receives them. Run the same check
   with qpairs=2; that would have caught item 1.

Info

3. Commit message:

     When set, the kernel drops outgoing frames.

   The frames are still transmitted; the socket just does not get a
   copy. The doc text has it right, use that wording.
