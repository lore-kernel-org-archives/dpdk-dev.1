Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFA8606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VUrEiZK5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7076F40DCD;
	Fri, 13 Nov 2026 00:32:37 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTPS id DA7734029D
 for <dev@dpdk.org>; Fri, 13 Nov 2026 00:32:35 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cd61cef87f1so160767a12.0
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794526354;
 x=1795131154; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6qCsMx3CPw8GaCnJAGzlykaEmX3OJRpQlfXiJuJ1YWI=;
 b=VUrEiZK52nE4d9VvyEGnxaBTUKazfBbJrr09WN1YFweicnYdNrmji54TJH79Ae6Oh7
 Qlz5SE/JVhbspfY5fdxEJYPbLS/QJjj9EICiwUhctdVf9iT5k2YuufMMdw0rXzNEOofL
 R/llE+5ZDtZBd0j3Mu5/jibON+K4iaDR6yvmv6uQeKaWBRpYAxusixbtckcB2q739QUY
 yHCwU8mq7e91JM3D7v0bMLGh0zsWZegUw/2//hEnWCugqapzDhW5hYodL94Wa89ADKzn
 raZWEi6ixruF7k5YHSrCgPBjKYjpw6kR+4/Y9P6ksxE1NMi0PzGaiE3JWnOZxmAqeX7h
 Bj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794526354; x=1795131154;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6qCsMx3CPw8GaCnJAGzlykaEmX3OJRpQlfXiJuJ1YWI=;
 b=YvpBSCb71nlz34eqKUeZrjdF1sACVHX3OrFcWxjSRBYVTNIFW1FeUhC+Ka60q8/bTg
 RfVTY66oqOcqG51zUM6jlEzg3wUBaTrCrDd98XgLAZXuF8E9I5BxMunN9DxO58cFFLkN
 PwpeskeI4Cf/mwAVGBsJ2VMEnPapli8WgqLauXRiOVDY+vu6ayVo8XI/I2ai+lCvYPn4
 8liRr+/Csw9FMvG9217IFByS+hyCxoENpLiItO1FmcgVVfQp9cPXJGtCeD9SnT3PPcT3
 RFGKRAFvamLz1XWP3BWv5ms7DfWb0fdlbZmAEAI/l1iX/hyKQt5aIEXn+RrnOJo6LS5j
 W/AA==
X-Gm-Message-State: APuU4Z99B8TkjfocCarqamyxNfWWaZTp/e+ReWKs/C7cJziIM9OAEmru
 vnNzwxyITwmVy9ubNIOBMpKSPSm6k/9TIaAfMjhYcAIns4+X9Ts0/4hWaa0selCfhyaIgh1U2T/
 0HQyHi/M=
X-Gm-Gg: AYBFou0WXdUEPIlkIErBlzTLad4w36VsY0KALg22rIR/Qz8qSNpPW9qQs+5SkB0oOVF
 f2iOUCQGMEMXi8kx5rTopHNqkjjWdp5C7n5cCiikKTrJIw6Hj743sjuVGx9R9BdrCdHZVU34g8m
 DG/gwQwMqlIm/lUKYTZoZ3ize98ga+mB6pTVLEwj4Q/yJpa+EuCL/7/0O9t38G8VNbu+KSIw1pv
 R4gRj67VlF6UmNbaxLp217FvAi0fxwVpSwabSEjC1rJ3OeQSIPCauU2GWsDBf3qaCKfokdXDPLq
 CoNyZjbP72ogKYv123N1V7VUlJgIjeBIYny9seYQTwVLTu9IozQGVjco60Z7OvfubgJ2Q2Xt6IO
 R88vYVV35GXpiUOj183v3AarxP3l2W6dyz9ouZxj7B117NzMKO8v61ni1Unla3oxtYhqsbLiB+G
 GEiN2y9PJ2ZzyFkMl+Z0EHZWcl7D2jjHyC6GKsVn/uhyiV+holt3rzMOlGUzew/6NuTISBZglJl
 Z6olsZOR7co8jbw1exOjAhfX3QlPIRLW1pPMi14GUVoFX4sBUrBZyC9VdSY0dMcUQliXbwfjmOj
 5ArzmahgVYQow05wus+p54kQFiXcchwSmyT01nbVThaM4+YPNwjXjt1aWH5EvOH+xZMiZCxTSQ=
 =
X-Received: by 2002:a17:90b:498f:b0:3b1:4018:bfdd with SMTP id
 98e67ed59e1d1-3b1b07e8596mr429241a91.7.1794526354004; 
 Thu, 12 Nov 2026 15:32:34 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197c6dd2dsm6465814a91.2.2026.11.12.15.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 15:32:33 -0800 (PST)
Date: Thu, 12 Nov 2026 15:32:30 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/8] net/zxdh: fix some issues reported by OSS scanner
Message-ID: <20261112153230.002d7d0c@phoenix.local>
In-Reply-To: <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
References: <20261107030448.2891345-1-wang.junlong1@zte.com.cn>
 <20261112102650.3162875-1-wang.junlong1@zte.com.cn>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 18:26:42 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v2:
>   - Patch 8/8: add the missing check in zxdh_bar_msg_ack_async_msg_proc(),
>     the hunk described by the commit message was dropped when the v1
>     changes were carried into the tree, only the reply-path check in
>     zxdh_bar_chan_sync_msg_reps_get() was actually sent, so the
>     VF-reachable path was unchanged (reported by maintainer review).
>   - Patch 4/8: drop the paragraph claiming what the compiler does with
>     the uninitialised read at -O1 and above; the fix does not depend
>     on codegen for undefined behaviour, and just state that del_flag
>     is read uninitialized when the group loop breaks early.

Looks good but still a couple of AI review items.


Subject: Re: [PATCH v2 0/8] net/zxdh: PF mailbox hardening

Series applies cleanly to main (26.11-rc3) and every commit builds
with -Dwerror=true. Fixes: hashes resolve and all are in released
versions, so Cc: stable is correct.

Patches 1, 2, 4, 5, 6, 7 and 8 look correct. One problem in patch 3.


[PATCH v2 3/8] net/zxdh: refuse PF mailbox requests not naming a VF
               of this PF

Warning: the pfid comparison does not keep a VF on its own PF, so the
"closes the cross-PF case" claim in the commit message is wrong.

Every vport-indexed handler maps the VF vport to a table index with
zxdh_vport_to_vfid(), which for a VF is:

	return v.epid * 256 + v.vfid;

pfid is not part of the index. As the commit message itself says,
vfid is allocated sequentially across all PFs of an epid. A VF can
therefore send its own, correct pcieid together with

	vport = { .vf_flag = 1, .epid = <own>, .pfid = <own PF>,
		  .vfid = <vfid of a VF under another PF> }

zxdh_msg_head_is_own_vf() accepts it, and the handler rewrites the
port attr, MAC, VLAN and flow entries of a VF that belongs to a
different PF on the same epid.

What the check does close: requests naming a PF port (vf_flag == 0),
and requests naming any port on another epid. The residual is any VF
on the same epid, not just siblings under the same PF.

The driver has no trusted record of which vfids belong to this PF
(vfinfo[].vport is filled from the VF's own ZXDH_VF_PORT_INIT
message, so it cannot be used as the reference). Unless the PF can
obtain its vfid range from firmware, fix the commit message to
match what the code does:

  A VF that forges the vport of another VF on the same epid still
  cannot be told apart by the driver, since zxdh_vport_to_vfid()
  does not use pfid for VF ports; protection against that case is
  planned on the device side. This patch closes the PF-port and
  cross-epid cases.

If firmware can report the vfid range of the PF, check
vport.vfid against that range here instead.


[PATCH v2 6/8] net/zxdh: allocate a zeroed full-size payload buffer

Info: the fix is correct only because ZXDH_BAR_MSG_PAYLOAD_MAX_LEN
equals sizeof(struct zxdh_msg_info) (both 2036, checked by compile).
Nothing enforces that. Suggest pinning it in zxdh_msg.h after the
struct definition:

	static_assert(sizeof(struct zxdh_msg_info) <=
		      ZXDH_BAR_MSG_PAYLOAD_MAX_LEN,
		      "receive buffer smaller than struct zxdh_msg_info");
