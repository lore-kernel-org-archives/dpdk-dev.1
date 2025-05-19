Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96398C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 06:41:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEE2D402AC;
	Mon, 19 May 2025 08:41:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3F82940276
 for <dev@dpdk.org>; Mon, 19 May 2025 08:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747636900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LFYqzcTubukAoMQInqYWj41aLmUEG4gAhgs2XCfWOo=;
 b=S3kDtAmzr6ZCu4SHen1Itp+drx3gSqQfDnwjprjojybZJ7x7/zbjIOTCb3O+4bIyug7s7b
 Xu3IRQVof7w4zmeskYO2Pnq9cAP8zLr2TPJ+TzoGmKzNHqaXwiohR+u71G3O2Y1/BsKng2
 iB8naV3H8fTzhyCOEBN29y4Szlt7/ko=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-DApbtjMDM_-i-nXP21tuQQ-1; Mon, 19 May 2025 02:41:38 -0400
X-MC-Unique: DApbtjMDM_-i-nXP21tuQQ-1
X-Mimecast-MFC-AGG-ID: DApbtjMDM_-i-nXP21tuQQ_1747636897
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3280329a224so16962791fa.0
 for <dev@dpdk.org>; Sun, 18 May 2025 23:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747636897; x=1748241697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LFYqzcTubukAoMQInqYWj41aLmUEG4gAhgs2XCfWOo=;
 b=LX0gZua6BgKosk+yeA8Ud1kuJ5qnNZqgpHxEvxUR5y9p6PZX5k+ov8roO0f60CDNXk
 3vSkskquDjCrje4m2gLeB31fpHJXxHx7xvQpAt921I/LVivaikdF4I3utlvQ0aMM/j9I
 kxVDECkJghTOi/gqZpwmz80MmiPkcFoZxekPpJwXF6x40HaJBOwAhDYvRA21O70wJ9ut
 udJiWkeMmCCWdNtYTAdbuL7el22jTH95CnU7ykl/jbuKZyTtSl6Y2EZDlH/igYiSagrY
 crn1ecihWE4uHorWhJkS19tHDFHNIUH7xCagJVTx70bL0J2pDnQTPbFGXZLfo0qNpMCs
 Pp/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIlAxNP81//lfRHLYmyRXtrpFOcagSR7CxfmZZMgerBVgtQ2KG/zjXMNVqZ2R8N9zFcrQ=@dpdk.org
X-Gm-Message-State: AOJu0YywhQO5mdMXEoQmfGwVH+BlMU/TN/YXjfI9q30tX+O5E4KAeAAs
 yycavDlL254wDNdNWlkWpe/CDwaa1laIM0LkphtveCLL+B/kgSAJx0z2qbs5zdA/ofKU9qCtAHQ
 D86FlzV+0fqngwYF1gHMKq8ZKZGHtkDBL3C+v57dWIAIhMNMp7WCEhrMetl7sXTE1mZEriDhc0a
 AU9Qbot8MfuXthbgwWW/U=
X-Gm-Gg: ASbGnctscuUd26tkNDPu8KkPojkDt5n3B5CVniacSXizouknXL/qBe0L+F6cB9179sd
 o0wh0TngUcRvC+SgOsRzF7i8y2TmlcnYLdVAzT1cHzPhjvLSSUFeaDU6bg7C7SlAeJ14rajg=
X-Received: by 2002:a05:6512:6409:b0:54f:c6b0:4b67 with SMTP id
 2adb3069b0e04-550e977f614mr3443956e87.4.1747636897363; 
 Sun, 18 May 2025 23:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmQXpMd5sM+WTplI/HBqWTXOEBPBy3z6LxAj5HZERSOWmVxyf3qG5uNpJm4EsdxWxlxWsgd9cAk2ZDGW6DpWQ=
X-Received: by 2002:a05:6512:6409:b0:54f:c6b0:4b67 with SMTP id
 2adb3069b0e04-550e977f614mr3443945e87.4.1747636896988; Sun, 18 May 2025
 23:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-1-wathsala.vithanage@arm.com>
 <20250517151736.2565461-2-wathsala.vithanage@arm.com>
In-Reply-To: <20250517151736.2565461-2-wathsala.vithanage@arm.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 19 May 2025 08:41:25 +0200
X-Gm-Features: AX0GCFt2lpt_bFFeiYNVFOHVxRRuZzWx65QurucVt4nkrLHLtTOUvsiGBdSK_HI
Message-ID: <CAJFAV8y6ZXpvZW-HTMC+0rqOeSRMm+15micF=XOvCFsN7kGWmg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] pci: add non-merged Linux uAPI changes
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org, 
 Dhruv Tripathi <dhruv.tripathi@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xdPph62wAP7OvUCg1y6XAe06wyYyrHgvND0KHZdLXqc_1747636897
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

Hi Wathsala,

On Sat, May 17, 2025 at 5:18=E2=80=AFPM Wathsala Vithanage
<wathsala.vithanage@arm.com> wrote:
>
> This commit is a hack to prevent build failures the next commit in this
> patch series causes due to missing vfio uapi definitions.
> This commit should NEVER BE MERGED.
> Next commit in this patch series depends on additions to vfio uapi that
> enable TPH icotl in the vfio-pci driver in the Linux kernel.
> These additions have not yet been merged into the upstream kernel.

Could you provide a link to the ongoing discussions (ml archive maybe)?
Thanks.

--=20
David Marchand

