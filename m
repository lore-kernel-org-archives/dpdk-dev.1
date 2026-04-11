Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512CF45A19
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Apr 2026 10:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E26402D7;
	Sat, 11 Apr 2026 12:11:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92274402A3
 for <dev@dpdk.org>; Sat, 11 Apr 2026 12:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775902265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jt+gRalR0Finn8bAy6RpmnQKpEoGPXIRqezsai4FT3w=;
 b=Wyn9vZWG1yB9viqlBC3EITFuaPiebBmyJi5A6owkbhColYXKhhSzoGDmpF0El7A64cypbR
 Yh+pKUsLa23tpbZ/Pwe7zi9qvb3+X6DU3im+Des4Zs3yYNQA6Byw5165q0G7lbo0g3SqEe
 lvl2cKm3DMwVT+8ofK1dkNVhsoKhUC4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-eIZOAffjNK2Jfb80I2eEqQ-1; Sat, 11 Apr 2026 06:11:04 -0400
X-MC-Unique: eIZOAffjNK2Jfb80I2eEqQ-1
X-Mimecast-MFC-AGG-ID: eIZOAffjNK2Jfb80I2eEqQ_1775902263
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a277331b57so2464260e87.1
 for <dev@dpdk.org>; Sat, 11 Apr 2026 03:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775902262; x=1776507062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jt+gRalR0Finn8bAy6RpmnQKpEoGPXIRqezsai4FT3w=;
 b=bwCc2EUzYxUZDBLl+A9wyHBHHkOtq5qekeEEL+NcvuO2lx5FO1GatcQwxMZ7kSR5Nt
 4iriVnHhaoaEj2V4Xi0HSViQq2D9i0Oie2mKfpQM4epCryGYE4QRQsL33DCPkvHJTenH
 InPO5KXfETUvFHvzABo2eTiZ3VBZDy1nF+YC+I3LMNHiUvnQpoXCVxHkUhccz85fBtON
 L8cUZeD7X0S70RxnrUzMAISbeFjimm76XpGe6+2PZji+WdlJon3BGpSkrGI4+wPvX94z
 4JveWGXCEjFQHs4ZpGx5qIAnEeMo+PXpSSWWKg+5HQuqXE0Ja10CSdlcDJetuY+RZnAP
 M6eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPBU3JT5hwpLzr1LGv1zusqWudNOFV++xzPJVHJT7WslD088VEU+U+b8iVdILYrc4SLDA=@dpdk.org
X-Gm-Message-State: AOJu0Yy2pqSWTKIh9604+dtdL7fiJG9PbTys2+NO3+goAZb8FdmTw7zC
 7Pc031i4D3cYAOtqjvPH3xAlWXI7aseAWiV2rB2PU9MITqj4nK6PfgwFYMGRA8YrWVS+PZyrBJr
 sON1x6Eoxuym9OJwM27AQewrk9xmt80gJE65oSAoRVtLzBKdV8iivQaD3obZHgQlSqopBXPu9aA
 zuiQUGPHR5UQyH1uEXeHs=
X-Gm-Gg: AeBDiesIJSTR4APjSDA65A/sksYX8M0zEesDp5Qblp9zSBKsIQqLgmNwXuBTISI0SFV
 LsIaEUwii5lc13u5dK3K5tBJhjk6bRjt56sZI0dwNuMmu/HtaXz0PFyht8eN7aXiSsnQeknvKWI
 zL5yDrvKblWhEey5KGZupX1oB7QZZxrK0PAQpfU/s0jeIBZE3lNfeVg91QgiDzNb6mKzqK0OPrB
 BzuS2U3DOLs8WK18AXWNkuau8YyVQW/hdlsxxUKFcw48jEVBR82LnsCG/724fpvHEoSjQ==
X-Received: by 2002:a05:6512:3d28:b0:5a2:a70a:a87 with SMTP id
 2adb3069b0e04-5a3ef7001d3mr1981485e87.4.1775902262326; 
 Sat, 11 Apr 2026 03:11:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3d28:b0:5a2:a70a:a87 with SMTP id
 2adb3069b0e04-5a3ef7001d3mr1981475e87.4.1775902261820; Sat, 11 Apr 2026
 03:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
From: David Marchand <david.marchand@redhat.com>
Date: Sat, 11 Apr 2026 12:10:48 +0200
X-Gm-Features: AQROBzAGzXvk3EEanxv66CQ3uX1CAb9GtkNqAwRKxEoC50x9OM5BJHRAKzwVepA
Message-ID: <CAJFAV8xPCsHY4OFLy19jDv4KgVbZotn1pobNGhokbuQcY1AniQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Rework device probing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Maxime Leroy <maxime@leroys.fr>, 
 Kevin Traynor <ktraynor@redhat.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v-8DTTPDtLv-NHac6W7W1g5iKRfrAvxCxa7oyBbjnH8_1775902263
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 10 Apr 2026 at 16:35, Morten Br=C3=B8rup <mb@smartsharesystems.com>=
 wrote:
>
> Is there a workaround until this patch is added, if I don't want rte_eal_=
init() to probe any devices, but I want my application to probe devices lat=
er by calling rte_bus_scan() followed by rte_bus_probe()?
>
> It's not something we really need, so if you don't know it off the top of=
 your head, don't spend time trying to figure it out.

Well, starting from the well known -a pci:0000:00:00.0 trick, I wrote
an incomplete workaround implemented for OVS.
https://patchwork.ozlabs.org/project/openvswitch/patch/20260226172429.21203=
4-3-david.marchand@redhat.com/

Incomplete, because some buses make life harder with some additional
parsing restraints (bus/dpaa is the first one that comes to mind) or
requiring a driver handling the device exists (bus/platform which has
*no* in-tree driver, though this is a different story..).

+    if (!args_contains(&args, "-a") && !args_contains(&args, "-b")
+        && !smap_get_bool(ovs_other_config, "dpdk-probe-at-init", false)) =
{
+#ifdef RTE_BUS_AUXILIARY
+        svec_add(&args, "-a");
+        svec_add(&args, "auxiliary:");
+#endif
+#ifdef RTE_BUS_CDX
+        svec_add(&args, "-a");
+        svec_add(&args, "cdx:cdx-");
+#endif
+#ifdef RTE_BUS_FSLMC
+        svec_add(&args, "-a");
+        svec_add(&args, "fslmc:dpni.65535");
+#endif
+#ifdef RTE_BUS_PCI
+        svec_add(&args, "-a");
+        svec_add(&args, "pci:0000:00:00.0");
+#endif
+#ifdef RTE_BUS_UACCE
+        svec_add(&args, "-a");
+        svec_add(&args, "uacce:");
+#endif
+#ifdef RTE_BUS_VMBUS
+        svec_add(&args, "-a");
+        svec_add(&args, "vmbus:00000000-0000-0000-0000-000000000000");
+#endif
+    }
+


--=20
David Marchand

