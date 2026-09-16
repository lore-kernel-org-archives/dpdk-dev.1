Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED2C982C1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 16:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81C714028B;
	Wed, 16 Sep 2026 18:24:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BDDEE40264
 for <dev@dpdk.org>; Wed, 16 Sep 2026 18:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789575842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RO0IuXr3pQJaTVUgxYsCoSbL5HBeC91FfK7jadrOiIQ=;
 b=fdVjsxBsjL1HWzvUXE+hcPtZUtK/SlswyJCKpOniSPGcaefE/geB8i6JhgqVjpYNVD/zSi
 7ZttJf8FzftvupvSG6jbDWY9QVb+blVm9HAUQMbigXINakvBgTbKqUnjjSUHJhhlGxuB3F
 jGb0n4uAdgOxtV5M1Ii6l7H4vcUhDMg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-TtBLDpkwP26pQjKdPBMLLQ-1; Wed, 16 Sep 2026 12:24:00 -0400
X-MC-Unique: TtBLDpkwP26pQjKdPBMLLQ-1
X-Mimecast-MFC-AGG-ID: TtBLDpkwP26pQjKdPBMLLQ_1789575839
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39b1a8b8bb1so24577401fa.2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 09:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575839; x=1790180639;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RO0IuXr3pQJaTVUgxYsCoSbL5HBeC91FfK7jadrOiIQ=;
 b=wRQ2epAclzVL+OhXtfvrRw34PZU4O9q+pDMRkBWEgan/CLfnI0DsMhRwIgp/fEPaIH
 mQbOM1BBcLtMzZBM5UjzJg5TCEKt1fv7k6x96mkrD1WPVNM/mo5p20vHIPl990mZ4c9k
 uloh3KyqEGo1gKKVin8lH6wunHYcWCsgdY+eA97LTL/V2Zk8/p1Ihq7eFgztgoZORH9P
 lGkK/8cXiipnjZIkN3LGM3iyjFg47Z4uCZIBmQvmwkyeiZkXa/vJ7sYMp3/b3S3DYlP5
 TGn8snKPsv8Mmj2aj6vCt96OoNThAUD1hnxOlPMwNhOo34ulY6Qc+zGCavqJfffM4YFt
 ydfA==
X-Gm-Message-State: AFuF++lgt5iDz7C3OrD9XPJ8Yi0HUchWn6cXDqRGKoqzGQjByCCTWqin
 5+yc6e+XGBJD7J8a59OSB3jOAfbwRZcRsgnPZF6Yl+HWC1GSdv19UEOyhZX8YRsK1ADPHzmKVvy
 7gOvfWAQnbCC3nvZLfl4z5qZhK5go/yt20o53xPrYxe/6KsLL7guZxJ2bua/g+abCgOVt0g/yeU
 BwhyUNKy0tr7+fpIKMzPs=
X-Gm-Gg: AYBFou3Zmc3++wCktEU7rJe8mSdHmm3WXFXbS2ba3E+ChKghsESmd0HajTG7wd1IuPG
 3cyaDqMK2g1zIkEyKWLBsykFdEDBZLe8kPWohyOBkmrIjZd0hgzA0izhVYBAITlwKUsqDy2Ajll
 XQ1tc4mUg9viqmIKTawZFlVT6ntoSsfLfMIti3Fb6JykReonX+VH2Vkmlz0P7ga+T/wcW4uTcpd
 j6cLSqpGzm8GMdpG6b0eFt/ET4pEawW1lo6HfUN0G2Ryxrb
X-Received: by 2002:a05:651c:907:b0:3a3:749e:319f with SMTP id
 38308e7fff4ca-3a5dca45dc6mr7223361fa.19.1789575839240; 
 Wed, 16 Sep 2026 09:23:59 -0700 (PDT)
X-Received: by 2002:a05:651c:907:b0:3a3:749e:319f with SMTP id
 38308e7fff4ca-3a5dca45dc6mr7223311fa.19.1789575838772; Wed, 16 Sep 2026
 09:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260902232630.543215-1-stephen@networkplumber.org>
 <apktnD0DgrDqxZTf@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <apktnD0DgrDqxZTf@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 18:23:46 +0200
X-Gm-Features: AcwNN1XtAorI77BJJaV_QlTwO1PRrIvOy-03-jxxHAMvixcHV9ZK-XtAscgr_N8
Message-ID: <CAJFAV8zjUr=1q516tZpZGix4s-ySb9kHfrZsWYc=uom1rwDFLw@mail.gmail.com>
Subject: Re: [PATCH] telemetry: promote experimental API to stable
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NultD9-YqKaIx0nssqpzACbUpZaomGVWHQW4uI9YgqM_1789575839
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

On Thu, 3 Sept 2026 at 10:20, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Sep 02, 2026 at 04:26:30PM -0700, Stephen Hemminger wrote:
> > The remaining experimental telemetry functions have been present without
> > interface changes for several releases: the hexadecimal helpers
> > rte_tel_data_add_array_uint_hex() and rte_tel_data_add_dict_uint_hex()
> > since v23.03, and rte_telemetry_register_cmd_arg() since v24.11.
> > Promote all three to the stable ABI.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


-- 
David Marchand

