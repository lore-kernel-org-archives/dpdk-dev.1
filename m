Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8327EC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:18:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A6C140430;
	Wed, 14 Oct 2026 19:18:37 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 66364402A4
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:18:36 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3ab9268d90eso2288682a91.3
 for <dev@dpdk.org>; Wed, 14 Oct 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791998315;
 x=1792603115; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BLaPI65aB/gHn10Bu8A8Wy2uoyT6JL70UY4xstkgK18=;
 b=ZiUr/noNXxdoAUTKdPuXFyJ0njyfACKBTYfWoJeltwZiDx3DUtWMan8LtOlDJhx+gY
 IAyHq64Rxh0GgyjnxRl1Y9ur59MIyqZ5kOzFcJTJ5qCxTbTkzdCVab+v8iGY3VLJXa/Y
 T+n2Gb5dNAmdh6ysmRC07216WgW7XMuZu/V4/xmAJyxxkM8Va9MDX80D4C7GOTUOjwvQ
 KXqyjWq5q7PaukzmyrwtGyflARHamOO3gXee0YvdM3F8mr3tptAWI/VeZDbBuZTP7wUB
 cEl4l8pP6F+g4AwkpSJxEtcvLZlzmy+rNorPjq2xi9wVk6bY1qbDzHkutEOh6V6Izmun
 2zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791998315; x=1792603115;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BLaPI65aB/gHn10Bu8A8Wy2uoyT6JL70UY4xstkgK18=;
 b=ZD7TDKd7hDDU/F08TAOwCTqVrMkcwMy5fsYcG817rpqXfrcLdkq+Dt1c2rKRofEzdk
 PG2F6JhAFvo2SaAxfKCh1V/OK8c3QhZTO5Fo3mw4RVMisc9Vb77JImLg+wd5B/9yPkqm
 zlQca3LCI9pTO5AdouIES72YB3Oo3NM+9csFZ508VlxGqx99yT01QUB2d1IueR1zphny
 1KoKjCPHrbfVrNRdRvyYW4UGzjfcQimeJZbxHs03QRFfrD+w1EqkvXiKPn5AT1PZEtlp
 +C6Xj4iu0nsYO0hN8SvJRpsAUaXXDVUMhi21xPX6zgcba5holnAzyQN+5fD+pT3J2ZqR
 yhHw==
X-Gm-Message-State: AFq9FYIA438qV22JVOhww7ip0qoMx8CcdEH52lKxruON4r8lCZvdK8La
 w9YUGfeWctHI5TQZZT13/PanisdFPPj3fTZXDR8Vw2PpxHw+XXPFRUgR3D/IMP2fVmQ=
X-Gm-Gg: AYBFou1TxbjqKPwnY3/oYCWaO5O+sTX33Wa/+dfGVskg4bqyLkbSFTvlIZd1lewxE4s
 6nUK3bQxkGwisPst/VVuBtvkDl53ZQcG2yFn3l5AkrR7h2+qfNINQNKeYH6uju387odrxIX9lRx
 fDGPxepUuM451/7AeB7aE0cqha2wc1qAWqgOc3xtsZB3mKJQGbCeghjBA9ROI+ZjaJFODoB7wAq
 xOB7bU3h/GtFd1kojBIW7kybXGNwFIbpsi4oEUCbTJLa0nXgvJPzykop1F+etP7akqDedrsptSY
 5I3ajM7DM5sPdSVbgL7qvDvbQhoDYxg7iuAkPOHoQtnbIh07DYBs83jgr9tZsmkCP/zZ7OtDyox
 9Y4AgF2dw0E1ZdA1AIsB/S2H8KZHPoTwu2nYc2S5J+FG2mvcvJ+1o2v+XTT0cD1ShcZkuLE8XSy
 U2gLq4sx0oTU6rCVubgOm3EwRS19YUPu6JzwYH5tWIFErlZ2xK9cUzjD6Y2fYyB1Q/FnO0C/Dcz
 m/cD8a4TM9oCimdX+NHlR3tSieafW1L+4xkJgPmgQ==
X-Received: by 2002:a17:90b:390c:b0:3ac:9669:8464 with SMTP id
 98e67ed59e1d1-3ac96698737mr59554a91.24.1791998315368; 
 Wed, 14 Oct 2026 10:18:35 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac947d2706sm247672a91.16.2026.10.14.10.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 10:18:35 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:18:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v10-S2 09/11] net/dpaa2: parse tunnel and fragmented
 packet types
Message-ID: <20261014101832.64838218@phoenix.local>
In-Reply-To: <20261014054400.980123-10-prashant.gupta_3@nxp.com>
References: <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261014054400.980123-1-prashant.gupta_3@nxp.com>
 <20261014054400.980123-10-prashant.gupta_3@nxp.com>
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

On Wed, 14 Oct 2026 11:13:58 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> From: Hemant Agrawal <hemant.agrawal@nxp.com>
> 
> Extend dpaa2_dev_rx_parse_new() (LX2160A FRC fast path) to
> identify IPv4/IPv6 fragmented packets, IPsec ESP, and
> GTP-U/GTP-C packets.
> 
> Map the corresponding parser summary values to DPDK packet
> types. GTP-U and GTP-C packets are additionally marked with
> RTE_PTYPE_L4_UDP to reflect the UDP transport used by the
> outer tunnel header.
> 
> Advertise the newly supported packet types through
> dpaa2_supported_ptypes_get().
> 
> Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>

AI saw this is it an issue? 
 
[PATCH 09/11] net/dpaa2: parse tunnel and fragmented packet types
 
Warning: the fragment value changed. v9 built it from
DPAA2_PSR_SUMMARY_IP_FRAG, which is 1. v10 open-codes it as 2:
 
	#define DPAA2_PKT_TYPE_IPV4_FRAG \
			(0x0002 | DPAA2_PKT_TYPE_IPV4)
 
Code 1 is already DPAA2_PKT_TYPE_IPV4_EXT, so this looks like it
was picked to avoid a duplicate case label rather than taken from
the parser spec. If the hardware reports fragments as 1, the new
FRAG cases never match and fragments keep coming up as
RTE_PTYPE_L3_IPV4_EXT. Please confirm the summary code. If it is 1,
drop the FRAG defines and report L4_FRAG from the existing EXT case:
 
	case DPAA2_PKT_TYPE_IPV4_EXT:
		m->packet_type = RTE_PTYPE_L2_ETHER |
			RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_FRAG;
		break;
 
Info: ESP and GTP values are now bare numbers (0x0005, 0x0014,
0x0015). Name them, as v9 did, so the next reader can check them
against the parser summary table.
 
