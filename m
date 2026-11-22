Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B91606A334
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=nOxmS+KZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31757402CC;
	Sun, 22 Nov 2026 18:30:56 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTPS id C6AB7402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 18:30:54 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso1067646b3a.2
 for <dev@dpdk.org>; Sun, 22 Nov 2026 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795368653;
 x=1795973453; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bN9zHdJy/uZ3vzhIH5dX6SepTnRUrRwO7B2X+mlZxio=;
 b=nOxmS+KZB6bkSihrlbG3Z9aSCeRwPBPJs2DqOBmoEHxZkHercpL/OjqDqsU3Isc8zR
 7yoYvXesCrsGrdHCdVEfv9wVTuOVVR8pezgj7kNjI2RjKts67hBsjAbuE6RB6/R+eOSR
 gergmjvC1lVJoFCqnGz6WPEB99nrOxU5NVZlSDuWaysEnxs/Vm7wQVRErc0uwzMhgIs8
 l3X+ZookXSIjbr1T+uN81aD2yhvVA9Myz7utNH25ns57KBaX8XTN636MdRoylpRagLGS
 o91yLMShPpbGJjjrEJmZZZtXs5TRy++WpkdOME9nXU62/ozU/WSXBVPKJy6K9yPqcvCJ
 490A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795368653; x=1795973453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bN9zHdJy/uZ3vzhIH5dX6SepTnRUrRwO7B2X+mlZxio=;
 b=Q0+yA6eIDAf7osu3Ia+/Re0R/xucU4f6My+dIGf+ruP+qSYhwi0l4+PUJ4D+tFSVNS
 d0/GWFcLAluNCR1SUvZC2oIWLO1jNE87PcIJaUPqes5/6OQ491URuVko7d6DiaxCj/Lk
 w81H2bNyY+UrbvGEwUPkBBEeZk+RFdP6urrhxwJQr+qOeolSOtXpMtDtCccONQ27MbpE
 CzJcsYofXjREkMDiqhbb5B+Dx9VefBaTW6Si0ZMSh8Sdyv+QvxwlL3+Hpe4OpeE96scq
 uDzFWzowUQ4d3zaPtkMN9K36nzuo69s0cTki92wjf4I9o2Lpy/jr8o6hDRyXmKNTOFeZ
 ferw==
X-Gm-Message-State: APuU4Z+RDrHFgpD+JAL4zRcmfBSuWj4wK/HNOH6ftgUnk8ajoqUfXaXS
 MIDjlAlB5ntnBPmnvj/Fsw0JEPzLrLwpcxK1u6xl4VkcvvwsDXuUaPdjRkMGO/cL6Po=
X-Gm-Gg: AZFdTZenXomYjnQtYVvkLAjcH8EbpNiWVzza8A39Rd8CT2gGqfjJrgFTMh3OucY20Jb
 WtA6SW7S+jptb0F5sXRGD5DiEajF61gUCwUzZpkP6v3wu1mc4x3610K4lARlHVE0X2EpMRxi9tc
 rTxBdLn/VLDwm+vBjlB78npul1GTFPm21dqK3wRkbrYmd2DFoxtU57FBttT2k8BJf3kOf4Vh/hi
 RVbt2RNHe08x6ZaEngjnu4vMHHn03WYfUYMJjaQHe/6pY1Db0tSV9RGviJ1w7Hsdqm/p1d0rgbY
 N7fQqma3q02LDSprbBVBz/QPaPCX+dJJy9022belFiidm2ILDxOb8+MVJIHKpZKL4hxeCMO9HBu
 fzOqG5CBn32PJKri3wvq3Jb5ZWC5g03WmCopIt3fACn8xjZroDopJUt7okKk6QiVYMiP2VvWepe
 JT5H6FxVtiBbydbjoWctTG2KPHk0lrAJXApXgXa/UhwyFN03zskaRLT2BWR8eWWX7uplsNABWSt
 2qNXZQnKbKRj8CBRMdMycga4lkG7/uTtgMI2Nw1YAx4LSwQW/OauYSJkToo3Os81kOCWP+avnSc
 InrjI2d/ewLKtJW0A24XVkCJweI6WzCNntiRaVVjJNuRwB/eJk0SzSSHOyUM/w5nAPzo6VkLyO4
 yP+lNydHDaRGQodCY
X-Received: by 2002:a05:6a00:124f:b0:89e:b12e:7ee1 with SMTP id
 d2e1a72fcca58-8c8794b9878mr7565472b3a.1.1795368652998; 
 Sun, 22 Nov 2026 09:30:52 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87344184fsm4336977b3a.35.2026.11.22.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 09:30:52 -0800 (PST)
Date: Sun, 22 Nov 2026 09:30:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ajit Kumar <Ajit.Kumar@amd.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/axgbe: retry transient SFP I2C read failures
Message-ID: <20261122093050.2936faed@phoenix.local>
In-Reply-To: <20261119173506.840405-1-Ajit.Kumar@amd.com>
References: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
 <20261119173506.840405-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 23:05:06 +0530
Ajit Kumar <Ajit.Kumar@amd.com> wrote:

> From: Ajit Kumar <ajit.kumar@amd.com>
> 
> A port's first I2C access to its SFP cage can fail right after
> axgbe_phy_init(), even alone on the bus: a quick NACK (-ENOTCONN) or
> a full stall until axgbe_i2c_xfer()'s own 1s timeout (-ETIMEDOUT).
> This is separate from the cross-port race fixed by
> axgbe_i2c_mdio_bus_mutex; it shows up on a single port with no
> sibling active, so serializing the bus doesn't help.
> 
> axgbe_phy_i2c_read() only retried -EAGAIN. Retry -ENOTCONN and
> -ETIMEDOUT too, with a short settle delay, but only until the port's
> bus has one successful transfer since phy_init(). After that, a
> repeat is a real fault, not a settling device, and shouldn't cost
> every later poll an extra second while holding the shared mutex.
> 
> Validated on AMD CRB V3C48 and Advantech FWA-1081: 0 I2C errors
> across 30 iterations of the cross-port repro plus a solo-access
> repro that now links up cleanly on both; both failed every time
> without this change.
> 
> Depends on axgbe_i2c_mdio_bus_mutex from "net/axgbe: serialize PHY
> and link status access" for the cross-port case; otherwise applies
> independently.
> 
> Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>

I haven't looked into all the complexities here, but AI warnings
seem valid:

Subject: Re: [PATCH v2] net/axgbe: retry transient SFP I2C read failures

Applies on top of the bus mutex patch and builds clean with
-Dwerror=true. Two problems with how the retry window is gated.

Warning

1. The settled flag follows the wrong lifecycle.

phy_data is allocated once by axgbe_phy_init() at probe
(axgbe_ethdev.c:2410) and sfp_i2c_settled is never cleared. The
first I2C access is not after phy_init(); it is in axgbe_phy_start(),
right after i2c_start(), via axgbe_phy_sfp_detect(). That runs on
every dev_start. After a stop/start or port reset the flag is
already 1, so the case this patch targets gets no retry.

The comment and commit message should also say phy_start, not
phy_init.

2. A fault present from the start is still retried on every poll.

The v2 changelog says a persistent fault no longer pays the retry
cost. That is only true if some transfer has succeeded. If the GPIO
expander never answers, axgbe_phy_sfp_signals() fails on every link
poll (axgbe_phy_link_status -> axgbe_phy_sfp_detect), the flag is
never set, and each poll can spend about 2s per transfer in two
1s axgbe_i2c_xfer() timeouts while holding the driver-wide bus
mutex. That stalls link_update on every port.

Gate the window by when the access happens, not by success. Both
issues go away if the extended retry only applies during the
phy_start probe:

	case AXGBE_PORT_MODE_SFP:
		phy_data->sfp_i2c_probe = 1;
		axgbe_phy_sfp_detect(pdata);
		phy_data->sfp_i2c_probe = 0;
		break;

and in axgbe_phy_i2c_read() test sfp_i2c_probe instead of
!sfp_i2c_settled, dropping the assignment after the read.

Info

What is the root cause? Linux xgbe does the same sequence with an
-EAGAIN-only retry. If the expander needs time after the I2C
controller is enabled, one delay in axgbe_phy_start() before
sfp_detect would be simpler than per-transfer retries. Also, after a
device has already stalled for the full 1s, does a 2ms sleep and a
second try ever succeed in your testing, or was only -ENOTCONN seen
to recover?

The "Depends on" paragraph belongs below "---", and the commit
message should not name axgbe_i2c_mdio_bus_mutex, since that symbol
may be renamed.
