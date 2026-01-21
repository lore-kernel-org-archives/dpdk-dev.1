Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22BCC44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 10:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58147427BD;
	Wed, 21 Jan 2026 11:21:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5249F427B5
 for <dev@dpdk.org>; Wed, 21 Jan 2026 11:21:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768990888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3K7MArpmlKZvn9y7lh/KRJlqL8K7ix0AKB8rFQVU86Y=;
 b=Tzo7Z/1WxJBRJ/+/aEcB5fYw/sndR5fDCleOwAqus9rvPCkXmEF1bSCoGctZ4AvDmw8msy
 BsEuyGVvJCAsU5/JXfi9CGS+9y+582YaBqT/vK6Dr2bcV6vurhdeLXR8UVFGhEwmWmMBgX
 JSyM18Dh2zZ/gP0EwftHxBwfwUPS9RI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-qc7bl_sFN5-cnPt6uiLSiw-1; Wed, 21 Jan 2026 05:21:26 -0500
X-MC-Unique: qc7bl_sFN5-cnPt6uiLSiw-1
X-Mimecast-MFC-AGG-ID: qc7bl_sFN5-cnPt6uiLSiw_1768990885
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-59b7b7a46a5so4434369e87.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 02:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768990885; x=1769595685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3K7MArpmlKZvn9y7lh/KRJlqL8K7ix0AKB8rFQVU86Y=;
 b=T017W0YON3NNbYl3Afqyuc2arCBFsn9xskQpvSJSKfIDcN1XFCaen3TuZi0nDN1wcF
 FlnfuDg0W4DWSIUantWWRG8fqxU0hIr4yN4cPoD7lJ/+moR2VCOvxo1gpSI31NftG+G+
 t1KGiYLtFKbzxPOCHjXlJMddvbEwCNiTU3/W/B5LD/VHCtW7+zGJaAEcDE687dIlxY9a
 Lhec5rLJr3iuDgeVJqAAyeqtjZgnNBNg7IUNwVmjeUHNOvToTYoDYh9HyID8ECrpMf+s
 GTMAuctj0K54GSWxrY8hOTzqUOLg6dXU499BgMzC49GdVvgLALgLkFMxmByjb6f7EBxp
 fNiw==
X-Gm-Message-State: AOJu0YxlPa3P3ysz4bVxWydDiHPQdccxn5th5NwpF5K4BqsvMRQ9gWhu
 pywbgnDNQysh5M3/otB8REH2w53tXthoWCEcrYLRNDLvcTXOQPNjPgUbCeL6oUXZXOpsXdnOl/+
 UMr1OEd33LeqvbUy84IVIaCnKhwLa30uAW0FYyJ9TSH+hQ033mFL6VDgeM7vBZBR+EDSfJIpW9P
 mwrbX/exb46UERbsjWJRc=
X-Gm-Gg: AZuq6aKucrPb4gbxWOhWpcHBXBkGZqC3YnICZ+Ikw9xnlvDmufKAftcllnoWSfgQcF7
 sK58KztA//hVAXvo7ijS+NPzPqbf92ElaLeKGFVJufoWv6ap5j+PglAkk9/5YzcYupEP7xi8kha
 AA6aplzlemQz74uMewljoylVEbdyUcXJ8zYTr2Z42EVk/5xwDgozrVqOIBt9PO/JWf1C2r
X-Received: by 2002:a05:6512:1592:b0:59b:7185:7596 with SMTP id
 2adb3069b0e04-59baef0b9c4mr5470213e87.47.1768990884989; 
 Wed, 21 Jan 2026 02:21:24 -0800 (PST)
X-Received: by 2002:a05:6512:1592:b0:59b:7185:7596 with SMTP id
 2adb3069b0e04-59baef0b9c4mr5470203e87.47.1768990884582; Wed, 21 Jan 2026
 02:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20260120231638.194471-1-sismis@dyna-nic.com>
In-Reply-To: <20260120231638.194471-1-sismis@dyna-nic.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 11:21:12 +0100
X-Gm-Features: AZwV_QgLqh2ogyZS_XReI5E39m0ckMXSkwo1OJ02RUQxyMQpt9C6SsKsPBOFqug
Message-ID: <CAJFAV8zF3iae8gqXmfgPVNuCaUzHHsUyxk4xY8U5JQPcJG14NQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] dts: fix invalid f-string syntax
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u1GLgohrZqBG3Sx3NIrcLKnBR4J03iVSftzSJsuYQT8_1768990885
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

On Wed, 21 Jan 2026 at 00:16, Lukas Sismis <sismis@dyna-nic.com> wrote:
>
> Extracted from https://www.mail-archive.com/dev@dpdk.org/msg326745.html
> to hopefully help move things faster.
>
> Sorry for the resubmission noise, adding the signed-off-by line I forgot
> previously.
> If this patch set is not needed, it can be ignored.

There was no need for separating this patch in the first place.

We now have 4 different threads, which is a bit messy (I am to blame too..).
Please avoid sending the same patch again unless asked explicitly:
this is usually not helpful and put a strain on the CI.

I'll apply this fix soon.


-- 
David Marchand

