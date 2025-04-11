Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3064C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 13:50:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BED340A8A;
	Fri, 11 Apr 2025 15:50:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 63EDE40A84
 for <dev@dpdk.org>; Fri, 11 Apr 2025 15:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LVX8CTaEsGG2H59yZV9LFMOcvYZdoAphfm9Il0Rra2Q=;
 b=ejUX0gZF3mkQrM7wsIEz2pkci9AD9TXiiHku3enKN4WSNXrvEibXH5ber8LZnTIjIfEaXC
 0fJYRp3vwUfdsAqvG0t1q3x/GvTa7hTc9sNXHu0jzo9Q3k0BfFZfpzDR0fM3743Mjgpj/G
 pv4JmfS2Ujob6UC8MSo/0YXnxa0Bjko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-mftFE3hIMQSQhHT2gdW0aw-1; Fri, 11 Apr 2025 09:50:44 -0400
X-MC-Unique: mftFE3hIMQSQhHT2gdW0aw-1
X-Mimecast-MFC-AGG-ID: mftFE3hIMQSQhHT2gdW0aw_1744379444
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d0830c3f7so15650845e9.2
 for <dev@dpdk.org>; Fri, 11 Apr 2025 06:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379443; x=1744984243;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVX8CTaEsGG2H59yZV9LFMOcvYZdoAphfm9Il0Rra2Q=;
 b=jVAB6OBCeNr/CTH6rJeKJcGXVGkrRCJj9eiVnxm4mdfVHAu9FZFAlgp7W7I1nCz+Ie
 5xirlaiB8YVW/85Ed1BY21pQJb68AzsYQ/7QRK+EZ7lsM74OK+VNrvc5ENaXkLmoFGwl
 zVdf267isX4oS3eal12bM3vJxUayngnlGPOpQL//4f26M6kd04yVr4nzUuOhREwTsM2E
 jnrF3v0CZqZ6eQXrsqcbH0DF9PnxYLxKiVpz16o096nVVpJ+HBVIIm5allaykxmHNblQ
 AWrjE5QU06gwOd5sV6k+X89rOh3kRfk3nt5zXsk0NVFVVEjQg4Bma2PpWuhCGVyigHjJ
 DArQ==
X-Gm-Message-State: AOJu0Yy4WgH67WMEmzVB3C6qLwEDyeop80zSbNxIWfiGs+V7gudh3Lr3
 IG7e3n67v3o02smYQYATh5Zr3ZSPgtdmfTvesJZ+T44Nbl1q7DYDjhRyBCLroxBm1Lg1WuvEshi
 211aiaE2a4IPJ3UBoERpCYj7UhUD9vBLDkg6b9HX/
X-Gm-Gg: ASbGncuppQWNnM0pJlIy3pjp//gnXWiP4Bx3QQ/lhWBuuxpRLSqfxzCYQenaWVa/avp
 5viFU1nsKMutsOz6V6HQdgt+Nmd8bshSBv6mraHS+FFd64GBK5H4c8gM762WEywcItE/19DKmlI
 gXPGPZKyxGDuofiRzBTKXk9lTRRbKPa9NSDgX+fZRugHj59emUCcXPFISwII3ekAwbdZiVbvNk9
 VPck/vL2Gy7/IHZXEuMeRxIb3R3Zz3DAbDKIbAzKA1n3tnEO0xMKLEVHPnIqADQB34y1iiO89GM
 rpR3WmycPPv1
X-Received: by 2002:a05:600c:3849:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-43f3a95c115mr25918095e9.18.1744379443514; 
 Fri, 11 Apr 2025 06:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqbwOFo4W/j2QmJatjiHdRLzxZNdyKpw1ClD0NrgDxhC+ghOAHVc7PpIK+GGXmhRDu24YrYw==
X-Received: by 2002:a05:600c:3849:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-43f3a95c115mr25917885e9.18.1744379443174; 
 Fri, 11 Apr 2025 06:50:43 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c8fb4sm88037625e9.35.2025.04.11.06.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:50:42 -0700 (PDT)
Message-ID: <9b28fcd5-a793-4301-8eb7-cfe59dbbb621@redhat.com>
Date: Fri, 11 Apr 2025 14:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.2 patches review and test
To: stable@dpdk.org, John McNamara <john.mcnamara@intel.com>,
 "Xu, HailinX" <hailinx.xu@intel.com>
Cc: dev@dpdk.org, Luca Boccassi <bluca@debian.org>,
 Thomas Monjalon <thomas@monjalon.net>
References: <20250328101435.250876-1-ktraynor@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20250328101435.250876-1-ktraynor@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FOwiW1dbkxHGwNo4LW15VIdGjmU1Z2lv8amKiPUzTPs_1744379444
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 28/03/2025 10:14, Kevin Traynor wrote:
> Hi all,
> 
> Here is a list of patches targeted for stable release 24.11.2.
> 
> The planned date for the final release is 14 April.
> 

Hi Hailin/John,

Do you have any updates or ETA for testing on 24.11.2 ?

If possible I would like to release by 15th otherwise it will need to be
after the Easter holidays, but if you need more time that is ok too.

thanks,
Kevin.


> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
> 
> A release candidate tarball can be found at:
> 
>     https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.2-rc1
> 
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
> 
> Thanks.
> 
> Kevin
> 


