Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36646C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 20:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A42B4042E;
	Wed, 26 Aug 2026 22:50:40 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id C8A4C4042E
 for <dev@dpdk.org>; Wed, 26 Aug 2026 22:50:38 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d049069377so17879935ad.0
 for <dev@dpdk.org>; Wed, 26 Aug 2026 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787777438;
 x=1788382238; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZHYL0uiKmaknG0HmFI1Gls19v54xolz8x4fBH8eAxQE=;
 b=eVeImBqBvWvoml4AUBkveVzlOk5vHgQmm34Bg6IfAKHmisYdzWFrARj8LunRBB83uk
 GGEraG01VG7VsBD86d09hACIavSipkwn77m3AmxDlziK3RzrVXxwNUvNYM5hebH6Stu1
 aJ5qfuXyHEdzkyftmEeg4toxsRxRM2sTldoeBiogoqWLyDlWttCngbzsSaKEgiUfRxkt
 8skth/jV2yBUUe6e3v9hoP6OLIElfCBQAfst+3SeYFgwf/8iGnY0wszVliCFgiCnpaHS
 3HnY50seu7SKPmvCzo0E9oVciaicPrkGMWr++Mlb9AOLtoW2pa8lLCmw3AzJ2R5ckS2Y
 s1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787777438; x=1788382238;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZHYL0uiKmaknG0HmFI1Gls19v54xolz8x4fBH8eAxQE=;
 b=ssHTBz0zrgkYz2NN5j+2HLw2NZI1nkH0Y3xOEVRkPwjGttwuohZ0n+BobqvK/iscSN
 3H1WEdmF5KfV4X0za4npAT3dUAk0db7549qZajnkWerLWas4wEoLoZrgw6DpHIHPTo5z
 dCZ9CkcrxHhoJBWPBKUtwoxQbkYYFjUDPtr0sTANMI8HqG38ugnPa6/uLEOZrXmXDzFw
 PiR8ggcjyOf+BNPhUeEG0qz1+Z6vyuwbI/UIKf33uStOYZ2cAf0IqMG19RGCasHvnKEC
 nE6PLh6UISDlfYrXkeQRPzobCCDoGOH2hkuPCXPmVDkXUM1mP+rlhHe5PERGfEs+LcaJ
 Qx4A==
X-Gm-Message-State: AFuF++mGwTnRpqFX89ywZGvwAI9oQdLUcV2SKQXqNKeerbTnRp4or1z0
 V1uh4XeuvnhLFSlIpTBnf1hZB2vJLw5U2JRHBKena/FANIbnkft22HM8XU2LNmxreto9V5hta0K
 po9gi
X-Gm-Gg: AR+sD11e14sV8E7wzruida8DN2dAe8aqsVP5O+YsFYWstNXvDNjCW7KNhJyuKpEBHBj
 YR74IWEkQdQCUE5NeNf3/wligoYSOAj7ER6kgZKCH++LqvIuldkoPR0GEqoPbyIZ5qRB6tGxGSn
 nMDc5SUxH6ex8HvVSzHISl2hmG6ynjwlPzKa0kVSRF3SZxS1UpJBghicUJAddVK491vZ/98pV7a
 m+vCrK1WHIFeSmmq9H7gpwJKpOLAZwZV4CAsxkmzBOe3RPBW0dCVPK+ylMP2vr+PcAFYgjYbhWs
 wMNKOdR7AH+fax4Mzja31HWAuJb3I/MlIUq+yZkXAMxw1c6c5L/CchewMt2XGuiEk7cSXrKBQKo
 54Cf+mGxHddfthJ7Er6Y0HMoQZYFxrPAsFjOV79Rf5iGevC6uUqoB3N2A40mdMjF0qFd1Z+ZawG
 K35x50Z7TKLqtwBNcNimtatl5pvjVz4a78o15UJ7BeWD9mPLj0nD4yeJ9+Cxc8shSnGMQgLu7MP
 9Arc1UgENL1a10n0ob0C/lB0J9ZBA==
X-Received: by 2002:a17:90b:54cb:b0:380:f389:447b with SMTP id
 98e67ed59e1d1-3966d40becdmr21113122a91.11.1787777437864; 
 Wed, 26 Aug 2026 13:50:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d993d1sm9399375a91.15.2026.08.26.13.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:50:37 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:26:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Bland <blandwwa@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/4] net/af_packet: make Rx VLAN stripped flag
 handling explicit
Message-ID: <20260826132659.56fcdb62@phoenix.local>
In-Reply-To: <20260826173842.1298754-2-blandwwa@gmail.com>
References: <20260826173842.1298754-1-blandwwa@gmail.com>
 <20260826173842.1298754-2-blandwwa@gmail.com>
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

On Wed, 26 Aug 2026 13:38:39 -0400
William Bland <blandwwa@gmail.com> wrote:

> Rx VLAN handling set RTE_MBUF_F_RX_VLAN_STRIPPED unconditionally,
> relying on rte_vlan_insert() to clear it again. This produced correct
> flags, but in a way that was not readily apparent from the driver.
> 
> Make the flag handling explicit in the driver itself: only set
> RTE_MBUF_F_RX_VLAN_STRIPPED when vlan_strip is requested, or when
> reinsertion fails. No behavioral change.
> 
> Signed-off-by: William Bland <blandwwa@gmail.com>
> ---

Applied to next-net.
