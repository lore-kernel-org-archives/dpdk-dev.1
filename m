Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E00ECA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 07:40:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4104E4026D;
	Fri,  9 Oct 2026 09:39:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C3F6C4021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 09:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791531597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T5IdurjE1On24G4v7sy0MISgbF16Vw9HSS9l9ijQiHM=;
 b=U1ak1NzXeLCXPyOXgB2SBvVLr+f2WuXo3UR8ZCNCwUwnzcbaAvfzr5KHbckP0s9P11UgDW
 vJx5xYQbm6ZR96y9sYhmXhJMWGlxbP6owEYVoSXLNuUzdX8t8GbBPFnxIVHCkaKLgVUU38
 hnAEGrEs2u1OW+7TjJspfZpLABV36RM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-DOBw4NrXNSqCQeTtCvgwSQ-1; Fri, 9 Oct 2026 07:39:55 +0000
X-MC-Unique: DOBw4NrXNSqCQeTtCvgwSQ-1
X-Mimecast-MFC-AGG-ID: DOBw4NrXNSqCQeTtCvgwSQ_1791531594
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5bcce2064a4so1286626e87.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 00:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791531594; x=1792136394;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T5IdurjE1On24G4v7sy0MISgbF16Vw9HSS9l9ijQiHM=;
 b=cFIHlqjQRfwotsG1giaxWjdKsAm5ySxwXhqkaXeu5dwyXS9l99Vi1muxE8YGDJgiEH
 E7OoNr4ZnMuPhHpZKGymKsz5NjSQyogFKiMrd54dXlKhwA35JJJK+MVsYe0KE/YnmgR8
 /YJZBiJXbsa3XxI8J915RkBquM7mc1lf+02AfNDyOn2gLOyNfaNLFdDeTDBfT8EmfuQe
 1kDNFlx0/Wp32GoZRfZekiEiJgCNKsa+yxILKYmpnI9HVFDizfAOaFy+iZdGZH63Hd9/
 qb63yBdlnBDvASIrVWUY9omwaAA2EZCp3xN1sm4/txuXYjKXIX1PEKD9b3/viK47U8L0
 RMqw==
X-Gm-Message-State: AFq9FYIRAsZKUL54GCwEvLx1uGrDNCv3ZfYx/ANJkknflWoc65Wc/GK6
 9Quk3wTnCihlhl2g1/Cy+QwTjxeF2bEBlj9zvIvZutyg7Ft5gFOMUTxvr02GC//YvtkXDetXKsM
 +2VGZLEUQ07B/NBjA96gg1DcXX+Srd02MEoC/2HuP7bPqtCvcwWCZZpY+9bf6oAal72sold3Es+
 EyHa16ZEu7pvojUdLHM4w=
X-Gm-Gg: AYBFou2G150k+r33P7MrvW+VPppKvqS7p8aCByutmVUo/JhcpFshg8rBC5grJCm9wW7
 ewnSLdRrtcaOIlgsq1ILlTlcOJoPie5H4wNEioypbvDNwQSau6dOaSyHQELxCjGVZbhFzLuRgX9
 RMaDM8Tkahfz4K50m+2znkVtGDWCA2z3v761goJrldDbTvcS6DAN1M/ph4dEpKSZ4WVdgjaLP4t
 m6XnO0iWDCZUZVP/0jrcH5otmLK+6XDr5D2RBhyGx8oaHeB
X-Received: by 2002:a05:6512:3d8b:b0:5b6:183c:5c99 with SMTP id
 2adb3069b0e04-5bcde6b0fc8mr382316e87.55.1791531594308; 
 Fri, 09 Oct 2026 00:39:54 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8b:b0:5b6:183c:5c99 with SMTP id
 2adb3069b0e04-5bcde6b0fc8mr382302e87.55.1791531593836; Fri, 09 Oct 2026
 00:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261008144313.2000554-1-david.marchand@redhat.com>
 <aseuX3zaIKN5eAOC@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aseuX3zaIKN5eAOC@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 9 Oct 2026 09:39:41 +0200
X-Gm-Features: AclHuK_irmmmt5_7Gj8oWuUOBIRXPMv0If0UCdqKdLiwwhdfg3ap-KAGmezRLxM
Message-ID: <CAJFAV8wiJ=w8JO3XMmnWA1L8RKfiFek2SRX_aHB6Fu8yd60MNg@mail.gmail.com>
Subject: Re: [PATCH] usertools/devbind: cleanup device type declarations
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Robin Jarry <rjarry@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G31sSwk4BrSSPZeL4XZNl-G3kLEdhX6WQAMyXG1OuJA_1791531594
X-Mimecast-Originator: redhat.com
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

On Thu, 8 Oct 2026 at 16:53, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> On Thu, Oct 08, 2026 at 04:43:13PM +0200, David Marchand wrote:
> > Adding more device types has resulted in a nice chaotic order over time.
> > Introduce a single dictionary and group by types (keeping the original
> > order).
> > Sort match entries by class/vendor/device values.
> >
> > The Sub Vendor and Sub Device fields are never populated, just drop
> > them.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

