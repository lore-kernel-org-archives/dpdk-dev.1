Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D9CDE002
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 07:24:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B935940280;
	Thu, 25 Jun 2026 09:24:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 699D44025F
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782372240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfUnY2Kt6C0vu290DflWLP+dJ396zTnkbag2prS7wOU=;
 b=INHYvNAk6Knpc+xali+rCxZIa8oYdMtysxeALEKeZYnhnfq2FjZ2u8u+soqWgomTYKy09b
 nFAp1uVdkTnw2O/bec1+oovsMELf9lYZ6rzLZVidxIlp8PiSVc6ieIk0fzTeca0z+Tj1ce
 g80lrJi+s1LI3sgLJnRYBLQ9tf4cB8E=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-OkDa5wcIMMW1VYE5NyCQpw-1; Thu, 25 Jun 2026 03:23:58 -0400
X-MC-Unique: OkDa5wcIMMW1VYE5NyCQpw-1
X-Mimecast-MFC-AGG-ID: OkDa5wcIMMW1VYE5NyCQpw_1782372237
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-396a99b2de0so7562941fa.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782372237; x=1782977037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfUnY2Kt6C0vu290DflWLP+dJ396zTnkbag2prS7wOU=;
 b=j5H4Mdnm1lEmIpyf0wRfUncaFTsS1QW7+zlc2j37PyN1ORYLge3d29YOc3FCDXE6pr
 A96pkKQfI23T4YvQ7NHuw+G2zvu8Sh327QLR+A/B2cEtokoBKTGhuxNL8drxZ9MFtc0r
 aog61+sMQxnhJ33QKMjXDHX2frdxDU05HKFZX50fYuKbFUwX1/MWI8A9CZfA1K3nCpRB
 cwIJLDSU0ikroPJU1oekFS9UaNXkNK9knGT1gaVm149iPjTIAjdB3fhpa2Y5PbqfQh0w
 AmNAK9TiR/3ZIc3KNXZFmFGQVAY4fYGhi5Qq4KkCEk/hrWT/zzYYvEfVya6DySCyTFsE
 Z1+A==
X-Gm-Message-State: AOJu0YzZWrjw6Yvrh9GyfCOurNjdOSpwXnDVamlLe1HZO3Q6hh8DoS0H
 kx7ojZzjejJPL1PMsmu4yNPXqqT+5fZl6ylYOHdow6i380bJXv1pvDO9oRBP4mq9KF+txcz3IkD
 /diwA1JmYv2XBlJ1k8nQL7o3w2phPA022WV5UyxkvYTbYkClM/avQgFb5LZn9H055h+JeND1zJ+
 W7avbMrRgN+Smm3uuOIVw=
X-Gm-Gg: AfdE7clO3C7JVHACTi69bqZsKrwR2UWOCTt14IRmpQMSBPWbXna5bpborokONnt7PWj
 VMOC0+iCr5nIJVTOvP9/qFdfAdzaTM+ndwt5v2rE0dsREOB/lsTVcnfS4Ml3JEQfxyNlqo4C8dS
 5QQuwzbSuj4lSVOGh3jZet160gFgIDEwzuzRpmhK5N6lQszcvCJlBVG4xdkwPM+nijYDbG3BvJq
 AVGJguPUtSk0gSsot7fibHy3OyE2yfUrnVkbN0yUfW7izQsJB1AKdrAfBw=
X-Received: by 2002:a2e:b8d3:0:b0:394:3deb:f360 with SMTP id
 38308e7fff4ca-39acb68e501mr2966711fa.20.1782372236540; 
 Thu, 25 Jun 2026 00:23:56 -0700 (PDT)
X-Received: by 2002:a2e:b8d3:0:b0:394:3deb:f360 with SMTP id
 38308e7fff4ca-39acb68e501mr2966551fa.20.1782372235989; Thu, 25 Jun 2026
 00:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014506.1866374-1-longli@microsoft.com>
 <20260624000531.1562655-1-longli@microsoft.com>
In-Reply-To: <20260624000531.1562655-1-longli@microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 25 Jun 2026 09:23:44 +0200
X-Gm-Features: AVVi8CduxhnHkyR_Wl1MX1NqKWSVSn89IkLlVDr0RL0C-5pmipBSd1w2AmtQFF0
Message-ID: <CAJFAV8yScD-2zevEo30YrA+93NwYi0qPseHZUbw2riwmnDSk3g@mail.gmail.com>
Subject: Re: [PATCH v2] eal: return error on devargs truncation in hotplug MP
 messages
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HJ-otZJKwQfeQYYDcB0olkennClx5D3Hr-90_vlH4AA_1782372237
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

On Wed, 24 Jun 2026 at 02:11, Long Li <longli@microsoft.com> wrote:
>
> The EAL hotplug multi-process messaging uses a fixed-size buffer
> (EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
> When devargs exceeds this limit, strlcpy silently truncates the
> string. This causes secondary processes to receive incomplete
> devargs during hotplug re-add, leading to failed port
> re-initialization.
>
> For example, a MANA PCI device with 6 mac= arguments:
>
>   mac=AA:BB:CC:DD:EE:01,mac=AA:BB:CC:DD:EE:02,
>   mac=AA:BB:CC:DD:EE:03,mac=AA:BB:CC:DD:EE:04,
>   mac=AA:BB:CC:DD:EE:05,mac=AA:BB:CC:DD:EE:06
>
> produces a 131-byte devargs string that gets silently truncated
> to 127 bytes, losing the last MAC address.
>
> Return -E2BIG from rte_dev_probe() when devargs would be truncated,
> instead of silently corrupting data. rte_dev_remove() does not need
> the same check because the length was already validated at probe time.
>
> Fixes: 244d5130719c ("eal: enable hotplug on multi-process")
> Cc: stable@dpdk.org
>
> Signed-off-by: Long Li <longli@microsoft.com>

Re-reading the function, I have one concern about the fix.

I agree there is a bug with multiprocess.
But this change here also imposes a limit to 128 that was not there
before, even if multiprocess is disabled.
It may not be a big problem, but we are calling the the multi process
machinerie when unneeded (it ends up with a ENOTSUP).

I sent a small patch on this topic, could you have a look please?

https://inbox.dpdk.org/dev/20260625072254.4190227-1-david.marchand@redhat.com/


-- 
David Marchand

