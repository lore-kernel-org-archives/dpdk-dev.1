Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454C606A33E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bl1B+hhq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52595402D8;
	Fri,  6 Nov 2026 12:28:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 5D603402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 12:28:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793964523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UHO7USVmiDKqj2UMxPSw5CrAi2SABQ+UJHiJlJ8RtCc=;
 b=Bl1B+hhqA6v77z8PbvlE+TXz7MCVXE/LpBMXwmSI8X5JBstTQP6XqYgWrnxzJQbMyWnjcu
 kGB+AKqp324BE8djjmL1s6LkNC2Xao7VfWkN0O3/MkDAQh4FdrP4K6ZO4B1A41VnlcQdSr
 vIptmZm9AUQJELsxhHdaYv041x4zCuQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-JmaKoSlpMcuL_7BVbe94lg-1; Fri, 06 Nov 2026 06:28:42 -0500
X-MC-Unique: JmaKoSlpMcuL_7BVbe94lg-1
X-Mimecast-MFC-AGG-ID: JmaKoSlpMcuL_7BVbe94lg_1793964520
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so4317975e9.2
 for <dev@dpdk.org>; Fri, 06 Nov 2026 03:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964520; x=1794569320;
 h=in-reply-to:references:user-agent:cc:subject:to:from:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UHO7USVmiDKqj2UMxPSw5CrAi2SABQ+UJHiJlJ8RtCc=;
 b=lKRbI6sYfEr4tOR+rbbxsE/XF7Cr4t1XSM9RrNhBw3TFN+NT6ukzPCK+MqkyEasB+G
 pjHOml+mNqoTLTZ9TQm3Ep9ZM+QDf91UE6RgbwVTWdXuq9R7VwGSUXx8KVoh2F7aD3I0
 DiYotPlsYGvOdwHMqZ2xIT1Fd+vcSdg+wiCkFwuOOVv6IaUaptBeFnSmRt7m5yWoE9zN
 agZq8RCvF8YyK0IRn+pm0IF15NIdYWyRJYbW0KROSxsySJYRpiIHgnGBRu/g39OC44hp
 YzPzBp994BkfoZh9yXWox9/TCGmyW0TsVXSTdqURfy/eLvh/Is+S5WB3aS6p9sXePUBe
 /FSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByP1sey3nCo3d03I+2GqRX9Xge3XTfZkB+I+VgkdiNv6m0pokHrH2JTmnNttEfi6MCHi2o=@dpdk.org
X-Gm-Message-State: APuU4Z/JCWz1noVwopgb2mDaDrxn2bwwG6Yq3JWKNM36asf61YaQ1Syn
 QbHp68g0YGl3QvNPl9IAT8tD5oxReGWEhuvLeztc31eSbQAGeGUXQ5zOTihH70pX3lbrbWV721n
 UWv4qIac+l9N0AnuoAtf0pO+l2bpp85Juck4aLnslTYS1QEUzgFC+
X-Gm-Gg: AYBFou0CREV64iGR4a5b3Y/+Ft/Z1ezbkDuDjHBLBepq6lz5nYE7bCcESlTuxbGU/z5
 st1OkMH39VSYO25yGUlNQ3NtElUVz0kTXmbQe4+4FIFjSZSMCIWG+Q5feY1KqH8W5OiRJRd6lDf
 R7MPQ0WyLv8Brofzs0y2foKrLbS/NVKLTw4ye2+V+W+KjrX6tDil/zu+Zd7nmtSFZu4a2F/pmIg
 dwrPWpxJpRxHfk+4QKW2dDFom7IUz2vBcjv7fN459Yb4mEbxdbSLZfqtDR/xT8oNpYcKKugyy+2
 E5uZkua01xHdCxRPmWvwXm4AMQsXF8N191eoCnLWeW9Am34fW81fBD2E62/MdRcs8ogQPC4sAU2
 pFFP/ofKW8XyX8o0+ScINowBgE/+QorvcsG9Y4j77XprwtgcgqQX/Qw1L+Xx5RsOmCVKbU+fUo9
 Ld/BV0kEHSeTfe9f7YN9XGfwGqnntYAQ==
X-Received: by 2002:a05:600c:3f06:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4b6dfba876emr31908005e9.19.1793964520153; 
 Fri, 06 Nov 2026 03:28:40 -0800 (PST)
X-Received: by 2002:a05:600c:3f06:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4b6dfba876emr31907695e9.19.1793964519816; 
 Fri, 06 Nov 2026 03:28:39 -0800 (PST)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b73b97d62bsm28597955e9.0.2026.11.06.03.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:28:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Fri, 06 Nov 2026 12:28:38 +0100
Message-Id: <DMO3CIMKN48Y.5VMB26462BGW@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/tap: fix use after free on interrupt handle
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, "Anatoly Burakov"
 <anatoly.burakov@intel.com>
User-Agent: aerc/0.22.0-38-gda2e3af216c4
References: <20261103171730.1361878-1-david.marchand@redhat.com>
 <20261106085701.2429186-1-david.marchand@redhat.com>
 <20261106085701.2429186-2-david.marchand@redhat.com>
In-Reply-To: <20261106085701.2429186-2-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YDfXdcreC1XGZmBulvb7FgWKiNxlmzo31OgmipAMAZU_1793964520
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

David Marchand, Nov 06, 2026 at 09:57:
> This driver was not unregistering its interrupt callbacks when closing
> the port, which now means use after free after the interrupt handle
> is not duplicated anymore by the interrupt thread.
>
> Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---
> Changes since v1:
> - moved unrelated change,
>
> ---
>  drivers/net/tap/rte_eth_tap.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Robin Jarry <rjarry@redhat.com>

