Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEDCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 12:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B2140676;
	Thu, 16 Oct 2025 14:07:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EFC1340269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 14:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760616447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMpFu1SlsHYYifZk9Itwb+KxYK+SnQNLLwqiaeCFKG8=;
 b=OzGlTLRGrBE+MjbyyvsOs4gp0dfHvFq0brdElUH2prtzh/GyNAWru7IDIQ4hz8PuRfuyJK
 MEW5JzdA3ppg1JRYjg+x2wwmYFz8ZryCdkKK8dZG5FXYkWSCqz5Qk48abgiXOUcItzNTYg
 h5SgTNymW8TV+iFvwx7jf3K0cbhbCN8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-HHhF8qBpO_C47YTbbK7UZg-1; Thu, 16 Oct 2025 08:07:25 -0400
X-MC-Unique: HHhF8qBpO_C47YTbbK7UZg-1
X-Mimecast-MFC-AGG-ID: HHhF8qBpO_C47YTbbK7UZg_1760616444
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so7358065e9.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 05:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616444; x=1761221244;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UMpFu1SlsHYYifZk9Itwb+KxYK+SnQNLLwqiaeCFKG8=;
 b=lmB5i5HQU32PJ3dpVDIpdxAFWYDTv3R7Cfmy4Tf4SyfQ6HsKvQ4PsScP3IoDd9COgX
 evPj3yRB9GQUxzjvJJv29fSG7/LgZ0w/qY3nhNb2okCPucAt/X2lfSU0kfOAa0ETqWjs
 KwJ0g8prx8dtx0DQNAbXhArStGPrh0ec4p/vph+rvaTWzsnX1NDn2NK6/5attE9OcMiF
 sXr4bNXmeMqvEkYF46w+g4hBzBTrmO0LtoH7jNlsYw5HqdrY0hE+/WgM1ZHTut0FRdKS
 Pjc/Or2SCbC8tDFQ5HNMHn6nu5jn9sJg9os3LfZmGxxzCvMHpydcTigjM+21AplsdlPQ
 dHWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKq5Yq9fINEsdqltvXNwmTNxFHU08gWpe5bTdhkWB+td8MjDL6O8FUTHsFohKpHIvJ7QI=@dpdk.org
X-Gm-Message-State: AOJu0YxRJrRnWeEPj6sba2W/jZB4MqHJlmu0wENFDfj/ktA1E5ELdLI9
 H8ykk0wg0xAS4QQNf2dD9ZUA0CDkI18uPVtVGLlTC/NWq0wL2DAtkXIvAek8qlzuMpYWEcOlvpw
 Fl+w6uCwGUZury+FYkO68LIG7jE7+cAeh70IeJjdxaItR
X-Gm-Gg: ASbGncs4IJ9gk1pUJFD0CqdFJUcOlP6L+FWgvs++Qd3Bs871q4FUd17yDP6/G9NTh9d
 bKnJ3TtzS+9vJrSglkqZqpc8qol60nKra5YlY2gu+YwWppexihiPBo4ghWQW2fV2iqlNl03efoq
 7VTht+6eO8C8H3wjy6vzfVa53h5bii7G8HHzSMfJ9N9DIL4gYEBHmdCHIVqKIhjLC+Q+7PjJPVI
 h92g0q2daaLQeOg8BafBe/OvL7jmyrAJ20KJlz/QTXXtC5swEaeYpOh8K/YaTNYjG1K82cs09HB
 AoL5+Fpk0hF9xKYvjvgTxpT5hxv+CP5HGZzA+Tg61nX8mVrRpmIGKyrdvUDagnAyHatG
X-Received: by 2002:a05:600c:a309:b0:46f:b42e:e39e with SMTP id
 5b1f17b1804b1-46fb42ee4femr131619805e9.39.1760616444216; 
 Thu, 16 Oct 2025 05:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGixiDFD/J7WC4jOv04mchtH7p6vYC+t3limYBh837Q+Qr/QFibFPTgNxpvxfJsf+Ks0s5JNg==
X-Received: by 2002:a05:600c:a309:b0:46f:b42e:e39e with SMTP id
 5b1f17b1804b1-46fb42ee4femr131619585e9.39.1760616443792; 
 Thu, 16 Oct 2025 05:07:23 -0700 (PDT)
Received: from localhost ([212.157.222.2]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cc0esm34652600f8f.6.2025.10.16.05.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 05:07:23 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 16 Oct 2025 14:07:22 +0200
Message-Id: <DDJQFVX2DBJ1.2JRSP0Z02RPT@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, "Bruce Richardson"
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v6 7/7] usertools/mbuf: parse mbuf history dump
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
 <shperetz@nvidia.com>, <viacheslavo@nvidia.com>, <mb@smartsharesystems.com>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <DDJ5GW4K1EPR.1KCSDT2O9LO5G@redhat.com>
 <aPCocj7Kn4KMTBm4@bricha3-mobl1.ger.corp.intel.com>
 <2863952.HovnAMPojK@thomas>
In-Reply-To: <2863952.HovnAMPojK@thomas>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _OGni7g9dXYKtUvvsJUTjHQV7EAFIqQZ9ZHkWkABPEQ_1760616444
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Thomas Monjalon, Oct 16, 2025 at 10:42:
> 16/10/2025 10:10, Bruce Richardson:
>> On Wed, Oct 15, 2025 at 09:41:18PM +0200, Robin Jarry wrote:
>> > We should have a centralized python linter process in DPDK. The main
>> > issue is that most of the code will not pass as it is :D
>> >=20
>> ... yet!
>>=20
>> For python scripts in DPDK I wouldn't have a major issue about having a
>> patchset with the results of a black run on them. History tracking of th=
e
>> python files is not as important as for the C files, since they don't ha=
ve
>> that many bug fixes on them to root cause. Once we get everything nicely
>> formatted then we can mandate proper formatting going forward (and
>> integrate into CI perhaps).
>
> I fully agree.

I'll draft a series that introduces *some* python discipline in DPDK,
then :)

--=20
Robin

> Filmed before a live audience.

