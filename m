Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438F1D2ED0C
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 14:40:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 402A2427E1;
	Wed, 21 Jan 2026 15:40:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 95A18400EF
 for <dev@dpdk.org>; Wed, 21 Jan 2026 15:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769006455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVMfK4aoBt0OAvLQnXBqWJA7glJBXs/u7YtOtM1KbTU=;
 b=VoU5fKjCg1RYnNBni62UYMKxfvEY5b/sF29u0TOJg3qLsV7apjDl/0qJBKC/3ikxDFRkH7
 lqKUd61ASRWVrfssNGp/oPsKqCInsULSif5lxlCTOZvk/AvthGiaSQ26L52T/TSlCQIuQ1
 aqzLnuN6dtssOXloaUMtVI8SwzUFvdI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-sGMxR5RdMhaknfFT_ebSxg-1; Wed, 21 Jan 2026 09:40:53 -0500
X-MC-Unique: sGMxR5RdMhaknfFT_ebSxg-1
X-Mimecast-MFC-AGG-ID: sGMxR5RdMhaknfFT_ebSxg_1769006452
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59b786498b0so6946215e87.3
 for <dev@dpdk.org>; Wed, 21 Jan 2026 06:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769006452; x=1769611252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVMfK4aoBt0OAvLQnXBqWJA7glJBXs/u7YtOtM1KbTU=;
 b=Q8EMVkzCuPzYEP5kd4v6AX8A9QrzrNfMXnc6IyHZ0aecy1AdzPCFoHhVxArMz/RIWT
 qvgeQNf63PiYi31IzG1hiKSv5J/uL/R4U4pxR+ICsjl30QYImRdO/uNNEI6DQDZVS4kx
 KkW0Z/fKUcSMn4J7zMH3xQCJv+kEPbKeN2Y7DYgTvFegg92uq6IT/8gqkoosbYmAGokb
 VezV4dmqufbCJFGuOvk/k4ggJwZXkVCxb2qhf8xYXW8trdOKZ6iAmFiM8LJRrCwX+v+c
 hqBdbPegN5ax5577d+CdhZSgefnJ7LXR2arSCC8jkueRC8f5BbM9VrfubQxiMxn2syvr
 NPhA==
X-Gm-Message-State: AOJu0YzwQNi95bjcTiwN7W6IGhlQTr7sqAcqcTHpI6nFCOMG/w6i4Rwz
 piTDO5iTUgLhmBj0zlukegsJgRNay/PHCG7CPqTvDRJaTzx7VzxjjMSu7VX/hoPJlN48m934i0U
 njO2l58VUCcCSkkOsD0oYdsNES63mxAwzHIfjL8NjjpnFizWCBoWiBotItHpsaURGyeRUB9elht
 Q7QGtMnyCPKXUQDheCz2Q=
X-Gm-Gg: AZuq6aLb2aS0NASJVH0OD1fcoz1DIRpJecR4BR4btJGIhKvdGOzoVis3YOh8XdhhhJV
 N70c6b0ZgsvixUQF2Ab7mPjT8BYMopaQpZ7ZVxa2xiRnm6St1+Hlw0KuRi/MzX4Zcd6ZyJn2YII
 R2GdbK4mMZkCRKI5X6zJumTSHOP+/KGVCVUvUkZqU5h1Z05TK8uMu5gXKE+MPBCWy59RdF
X-Received: by 2002:a05:6512:15a8:b0:59b:7291:9cd9 with SMTP id
 2adb3069b0e04-59dc9360f4cmr2341790e87.48.1769006451696; 
 Wed, 21 Jan 2026 06:40:51 -0800 (PST)
X-Received: by 2002:a05:6512:15a8:b0:59b:7291:9cd9 with SMTP id
 2adb3069b0e04-59dc9360f4cmr2341781e87.48.1769006451278; Wed, 21 Jan 2026
 06:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20260121100127.1701459-1-david.marchand@redhat.com>
In-Reply-To: <20260121100127.1701459-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 21 Jan 2026 15:40:39 +0100
X-Gm-Features: AZwV_QhDuc-VmfiCP4Uftuw1imJs2npQLFKufCd3J9r_rG38GplzR_BP9DBaOII
Message-ID: <CAJFAV8zMV-5kVAuCHwGu7JMONdewEERojpTyaWA8vv0asgGSVw@mail.gmail.com>
Subject: Re: [PATCH] doc: raise an error on warnings for dts
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, probb@iol.unh.edu, bruce.richardson@intel.com, 
 thomas@monjalon.net, Marat Khalili <marat.khalili@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DAhEn5-ncI3-eUd7V0q-oPpxhmk17WpyCFkLKejJvhk_1769006452
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

On Wed, 21 Jan 2026 at 11:01, David Marchand <david.marchand@redhat.com> wrote:
>
> Similarly to commit 6572fc926037 ("doc: make sphinx comply with ..."),
> pass -W to sphinx to catch warnings.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  doc/api/dts/meson.build | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/api/dts/meson.build b/doc/api/dts/meson.build
> index 8a6d061879..fc147f13f3 100644
> --- a/doc/api/dts/meson.build
> +++ b/doc/api/dts/meson.build
> @@ -12,6 +12,9 @@ if python_ver_satisfied != 0
>  endif
>
>  extra_sphinx_args = ['-E', '-c', join_paths(doc_source_dir, 'guides')]
> +if get_option('werror')
> +    extra_sphinx_args += '-W'
> +endif
>
>  # DTS docs are generated inside main Doxygen docs build directory
>  # DTS docs relies on main docs to install it so does not define install dir

Applied, thanks.


-- 
David Marchand

