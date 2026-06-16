Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F7ACD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6063B40661;
	Tue, 16 Jun 2026 11:18:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BAF2740298
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:18:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781601481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YCY4I+Ab4q/CUEka95w69DSqUGN1Dh0YortonH/gSFU=;
 b=OMjk6QKXXf1ueTKnW/dX58fXms3Emj9X5RCRj5ef8BNaheSxX7nLlnhrQkIRqXsuQ7xDVM
 A7EIzlASvoCx1ODgY942Jhelm2hGBGFQsJgLnUEPyer9m8zuNL9uEpRskSwumTY22cvFk9
 JOq2a5sHrnhKXQBY0nT//ep0x11+NBs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-zr0ATB7PP--8pBVuW0R1Nw-1; Tue, 16 Jun 2026 05:17:58 -0400
X-MC-Unique: zr0ATB7PP--8pBVuW0R1Nw-1
X-Mimecast-MFC-AGG-ID: zr0ATB7PP--8pBVuW0R1Nw_1781601476
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3966afc5d18so13539811fa.3
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601476; x=1782206276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCY4I+Ab4q/CUEka95w69DSqUGN1Dh0YortonH/gSFU=;
 b=Gju6PcKObx41loYiXAFwQsXwiORFjcdOd+zPJeOCA95YSoGJPejjB9BCmEgmBPAvek
 oq2eS9hIxEk9xzQP8Jlq+x1fyeQXwufdJikOy63t1F4UPwBiZ2cmWM090C2qW8IcRyRR
 tI8mNqli7UejsqeCUj7kS3pA4uCcjL7Frjsz6Mhzc5WYI+PW4h1j8kV/6hW9dCz697H8
 kkxLk+oO33I9OSnwJjuCsvA23z04u56I5K3m2MfjmFRGcK9OFXTc9RJXbh/yaTQVSvMZ
 gX3iTym8YYNu9MtYXAxh2R4HpSTkAjiCk2GwzKJcKLHJZQ+l6K1lHSdwHu5a3+M7qFrt
 IVtg==
X-Gm-Message-State: AOJu0YxYEGXQrL0xBR30tBFBibti/Ql9EcE9865OR3GfGZVUFcjbvxdt
 tsx5CjU9KfFodFYysHc3DlPjF+PVEVIu2nLdb+jL5pmi2Iejn6V/VTo/+AHHDS/b7h5rT+hnRUU
 NM0fWH6HcF4x0y4xBQ6NpWU8XWLcnqW54UyU4YDkqdY33rNdA6pkHAtZ1gm6T/+V91Bmhuv7dUC
 FwnY7iJ/89oyBA3idbi64=
X-Gm-Gg: Acq92OFWi8ydJWCy2qah4fyymJQ47V2io0UHX5tyjBwoa3vspfQNXNQzB0nvZmSEvJl
 XsDFX7KOaI78dLxyyiBAqAruPBIBeFUErHCbet8wbBdx+d3x0SbJzHyWTSgtjAJGssNTBcljQN2
 y1/SvyVRPjSOrMXb0ExcVOc7niXJxu3OnwmXimIaRD39oSXINAFYMGXfXXdylES8vlgK0lxPDJY
 3PBAOVoz2NWDobFfkJcxrKbcSv/5XQeWvBVq94MG8D9M6l6cJ0dLV45ThBskupajK7JEw==
X-Received: by 2002:a2e:bd8a:0:b0:393:a7d7:7e84 with SMTP id
 38308e7fff4ca-39935773dd6mr39984611fa.24.1781601476345; 
 Tue, 16 Jun 2026 02:17:56 -0700 (PDT)
X-Received: by 2002:a2e:bd8a:0:b0:393:a7d7:7e84 with SMTP id
 38308e7fff4ca-39935773dd6mr39984511fa.24.1781601475803; Tue, 16 Jun 2026
 02:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609155419.263787-1-stephen@networkplumber.org>
 <20260609155419.263787-2-stephen@networkplumber.org>
 <cd21b6e3-1efe-4ad6-9110-13b8c88f3248@huawei.com>
In-Reply-To: <cd21b6e3-1efe-4ad6-9110-13b8c88f3248@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 16 Jun 2026 11:17:44 +0200
X-Gm-Features: AVVi8Cf2Xlg92MeTNQ074XK--vDcUPaXkmsPPWKoOlIN6q8mPEdw478YZ7SXuKE
Message-ID: <CAJFAV8xrcXbbaxeie7NWo+TZTwvzTXJiFpkiM+SUeH1dRi7Uag@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] eal: fix off by one in in tailq name init
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>,
 fengchengwen <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QZfA5j31JuLhaD5wd95pwhjGWDQWKtUT_PXmyAJr-7E_1781601476
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

On Wed, 10 Jun 2026 at 03:36, fengchengwen <fengchengwen@huawei.com> wrote:
>
> On 6/9/2026 11:53 PM, Stephen Hemminger wrote:
> > The tailq name is defined as 32 bytes, but name would be
> > silently truncated at 31 bytes. The function strlcpy() size
> > already accounts for the NUL character at the end.
> >

Bugzilla ID: 1954
> > Fixes: f9acaf84e923 ("replace snprintf with strlcpy without adding extra include")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.


-- 
David Marchand

