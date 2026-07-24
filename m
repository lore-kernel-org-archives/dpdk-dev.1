Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7CC531C9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:58:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 337D74064C;
	Fri, 24 Jul 2026 18:58:16 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2A3C4402BC
 for <dev@dpdk.org>; Fri, 24 Jul 2026 18:58:14 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-848643382fcso759720b3a.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 09:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784912293;
 x=1785517093; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Z08eVhTTg/daicK0mYqZpu981cuw3sgmSCs7RkOoYI=;
 b=yr5OJlHE+vxTQYdbtd9wrud9M1UmWsEQyfgpLihxdM8ePiase6cJX85qV7BrkX8zuU
 p9vx0ctrgm24vqA0lvvW6M30kKNYK4q/HcundVdlTb6QwqWRxp5dBwZPUSbMHiTBLJEk
 HOqJSRnA4fCpcMgO/YrXi5pKPDee5C+GQq7hp038m4dBRRhdWG/7ctq8Mk/IefugQqKJ
 EKkJar2uvgo24n6U709RwBN+7fp+aYsQEwIB26BIThJx13dsoHVZMeHu9vsei9Yhn7yK
 oSRpsx8Ex2oE3eFwtLHZZLRrH1WqmbX6C00jl3MT7s0Sd0myj6YZSi7pNlGrHbZUkwDF
 6Hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784912293; x=1785517093;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Z08eVhTTg/daicK0mYqZpu981cuw3sgmSCs7RkOoYI=;
 b=T8XE6u6lv0+lS6rkzYo9huS0WAIu7SKWykh4Rq/39G/cfSme1LzXSIEMmg+1qzOJ/w
 Zal7lE+Co/fk/0J5sDgEr+wORSxUrPO2atTppa0AGop8BWIBn8bPuJke8uFRgxOQ30vu
 aiHQP2q0y6xzq2Q9iC0Eg6YRT6ScShjITIz1adD220jb9qDIpctP9Ll4iBdLDtsP1AZ1
 STPS8jJwOKHCWQzoRTn9ptIGerbvMqeu2AdJMGEgn/qpEphndSxe32KJkU757CvQzTJS
 l6e41OBLeYutxVxDpXbt+EHlLlRJlLWXFeiluJVoffVmpqYTntqQ7jmEZq2acURspDUE
 Us7A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq59/Pre7e/po14JzWjl0FHetp12Nb5b5eDNgjNeNhHDTdt5sCVHoMGJ9Ff7UI7/QGA5oI=@dpdk.org
X-Gm-Message-State: AOJu0Yw6HoFYuIL7HYNmUrloB1MMkN4AJGZkIJIo9H+joI3eA45ZanXx
 B8OXKJMJwrkLC54IFDl3JINHGTmWH/JtZytqv9c3V8q7N9AKIV8gErQ876CP0CjrqXk=
X-Gm-Gg: AR+sD128oOf6tPgFpGcvhpt+0O1zTCu+ici4zMmy9MFEEIk4wdZLbS8gpd5LKMfwZ9G
 SJLNhVENUyERfKa5noQR09uOCfiBeJ4lKSNiaLZG8gxdh+pV7avS9MXy6p2MrC9jJMhKWyoStrd
 +OpkzjBJgS/RijwkqFs9Ic2YdkkBjBtoM322RPG6mS7O3CIN/NK934zI/z8MjRKCESUEUeH76h+
 B9EDPIsi85jLTisWCU5CrcMMnUwO+PrTJgzNDi4rTDfz6+8U9SyNWSTm7hiYxj9UhTruKtlBiDM
 OgtbMY/sTuZkaftLNxMsN0o4P93Px/SxW1lJ/RPa3y3SQzhbOGXCWeCQz6+AELfkZhpupPmpp89
 Hxf26NZdGAapdmy2FlLpa0iEkOlscJU0bNz2uT+IQmsenBbA1ycoYor24OIMbl43cu1XLKB9O0c
 KVzCtXNl4wp4yjV85qUdXMZ8YqkvSvp+EjuHrWyEfXs7cQX851xhkAtg==
X-Received: by 2002:a05:6a21:648b:b0:3c3:89cf:f43 with SMTP id
 adf61e73a8af0-3c44b040654mr8798457637.30.1784912293071; 
 Fri, 24 Jul 2026 09:58:13 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm1152158eec.29.2026.07.24.09.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:58:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:58:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Cristian Dumitrescu <cristian.dumitrescu@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com, radu.nicolau@intel.com,
 kamalakannan.r@intel.com, harshad.suresh.narayane@intel.com, Thomas
 Monjalon <thomas@monjalon.net>, dpdk-techboard <techboard@dpdk.org>
Subject: Re: [PATCH] doc: postpone deprecation of pipeline legacy API
Message-ID: <20260724095810.68212695@phoenix.local>
In-Reply-To: <CAJFAV8xrQtp4QGzWYkBDBD6YcVx3u8Zx6H3+jKSw103nCxcHyQ@mail.gmail.com>
References: <20230719151225.1658316-1-cristian.dumitrescu@intel.com>
 <CAJFAV8x54u5zCRZdfzRe=BtxQmryuU_pEK=6CU9RBMAGyVdxOA@mail.gmail.com>
 <CAJFAV8xrQtp4QGzWYkBDBD6YcVx3u8Zx6H3+jKSw103nCxcHyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 24 Jul 2026 10:00:56 +0200
David Marchand <david.marchand@redhat.com> wrote:

> > v24.11 dev is in progress.
> > Time to drop deprecated API in those libraries?  
> 
> No news from 2 years.
> Please work on this cleanup for 26.11.
> 
> Thanks.

I did an AI powered somewhat brute force RFC.
Probably missed some things, but it is a starting point.
