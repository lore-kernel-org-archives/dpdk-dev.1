Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603CCCD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 15:05:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CEB240150;
	Fri,  8 May 2026 17:05:34 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id A99CF4013F
 for <dev@dpdk.org>; Fri,  8 May 2026 17:05:33 +0200 (CEST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so3095389a12.2
 for <dev@dpdk.org>; Fri, 08 May 2026 08:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778252733; cv=none;
 d=google.com; s=arc-20240605;
 b=JL2+hY9HWpywUG4USPEFoQpDnMv/yXm4b+MkthsdqZN4xNePY1sFrl3IMbBTKhAU8H
 V1mZMpoJpJU+q6pf95+X2ni+2qNkQFrHDfKmBp6TDnTpSkegHem7RwWE5nLd1NL24E3B
 p9F58vWxxUNDlvFTlQnS7G0vBQZmoSDLLnA2YqG8UGDHj9Dq2RQtw8WCEIE/pbeRBA7w
 qeP+EQ3Gn8Rl394WZMMfY7ElKYNQUNhvv9HHJcUOV+mhnulMJzMPlWKtlnQKebZUMjGN
 yW43jldVUfD36DyWOJP2hD9nYZ2N0+XmF1eTuQbOJir+adDoNEYHnTvHPyghNLLP/Ru3
 94HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qZY3WpMu4b/TNNofOgaqUVLfPb+yXXRdghnKHHDZ36k=;
 fh=yQk5J478VWv3V7GfAg15PVL7CU6nOcWqmvRTFKhoDQ4=;
 b=Q07nzVIaSBUloYPSatFX0tMs/NNJfDHFLuODhjCbSdAxK5LsreOi/L1DjbwsDQms6w
 lazEK0oDqp0nN6jW6h4393Xkd+GrFIe8o/rEprMmpkqMaRm/RAhcQMPvFFO0Gyn7gP3I
 4QABYcyhm7PMmoaz31zC2JvEkq4kMW/eiXFW/HlUBHWWHTym0DnvarBjrFYaqSMy5fD5
 38Og+WGayzEdPa1zVx7+Z1SZ7SldarhgL7HeOXj0yPTwlc68KvoTT+VmYj6AUzAoE34V
 4Hzmp2jnwo5LVaIO+i6dpIgXQ37tWCsgFC62s31oizaypEMC3Oa+ozWYyRYIc+cLfYsx
 9OeA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778252733; x=1778857533; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qZY3WpMu4b/TNNofOgaqUVLfPb+yXXRdghnKHHDZ36k=;
 b=cJ29h8/IaGTocbQpfJ0gg53Oi1i5NF+vltUi7S8wgVGsLny3SCcDeH/YBvx6Tydh79
 k3KS0soCQkfqilNHtXHqUqnbyX7WkkY9yjXkBUgE8zfpn3moNPAdaZ3zZ5RVNZj/bD0U
 z87j5otj/Cy3V9nf0nsom7oXNr4poiuhreJsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778252733; x=1778857533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZY3WpMu4b/TNNofOgaqUVLfPb+yXXRdghnKHHDZ36k=;
 b=P8HFiF8fPLRV+PIfRnjNiKdCIBnAjXBf3Hl5xTuxbepkZQl842VCWuN1wOsVfDcNQf
 Kv+b9OsyWpUfBuXdpJ37fIyaJ4AhR7RJei0/0aoY66TsjpgKr43Z84VCRHEFIUYdXxB7
 ZJv3bEfpvmOhDHHhs7ya5oqQ5A0JH2uQgj58HQAWtzJz2pZx0xcXwZK9TOgrBNy8+UHF
 oGph0GVMeHVDYfka1sate/X+27WaXTmejojU6tJv9HyzX8NNxumvQNVVFH2Z2inR9nDv
 1X2WdFmQ/VJfKRQidrsvILywC2HwywyDXZJ81ur2Oy22Ox5cFc/S9Mv0eiPABJqmMMj6
 Mhpw==
X-Gm-Message-State: AOJu0Yz94JaYGTzoIC+43SD/Le0GB6dn05JF3XWHZpI7DPaPz6PkTU+X
 +kQj2g6bwy9ktTLwiVLY2NajfAV2eZFhr891rLIl32Df/Jz8qJX94TbdLCdbmmyDf1JP3bo8jis
 YIYkf9p5O11XHDXmAN0ljGpE2CJHi8z5yPuGnIvTGAM/zgr4st0XH
X-Gm-Gg: Acq92OG/M6ELgdwmhWfa147cTh9aQihoHLID1Vf83h39hefkppVv4NqKVUU7ugHMG5k
 hE7fVtrVcmbgA0eoOKtITd4WmxJ0Vs5ctwAZ6vUFdJ1xPbKERxlLNVG5Uzg/01JujThobjfyJ9L
 Fhw/1s3Xdl0I1LutkKtYa3aM1QrD19QQ6JsYTb/l8WfOlflPtg54vtlBa1eLgYhGB4ekZ8qlChS
 tSiVBDpSkOh3B8HfRW5RE7pILZlpMgoEU9rMxZKE3tFTgOi4+3tUrV8tt8s1Sq1RqoWgLKZavhO
 6sG20zolRtCOaeRXj4hFRNx/9KnhChCtKAwk1uXZlEd84uwqxZ8zFXbCpIPHDg==
X-Received: by 2002:aa7:d9cc:0:b0:678:f81a:76a1 with SMTP id
 4fb4d7f45d1cf-67d63d8f13fmr4897580a12.10.1778252732641; Fri, 08 May 2026
 08:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260507163659.40739-1-abailey@iol.unh.edu>
In-Reply-To: <20260507163659.40739-1-abailey@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 8 May 2026 11:05:21 -0400
X-Gm-Features: AVHnY4J9Kx2LKh48qnCTqgZw28dAkOgdVCydH039txoDBYN00QtwGm9Pt1qO03s
Message-ID: <CABJ3N2Xmy9-HCLzN5EWeeOFyFiEKTiP3DAk4wEmzVToe0uxDvg@mail.gmail.com>
Subject: Re: [PATCH v1] dts: clean cryptodev environment after a test run
To: dev@dpdk.org, luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000073441806514fbaba"
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

--00000000000073441806514fbaba
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Functional

--00000000000073441806514fbaba
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div dir="ltr">Recheck-request: iol-intel-Functional</div></div>
</div>

--00000000000073441806514fbaba--
