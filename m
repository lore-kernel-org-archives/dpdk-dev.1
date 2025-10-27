Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B876CCF9EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:58:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C7644028C;
	Mon, 27 Oct 2025 17:58:52 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE634028C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:58:50 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so35100215ad.3
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761584329;
 x=1762189129; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m8UeM8WArxna7YTxUHoHINCBMaN++zqrX8DMKwWVWk=;
 b=g0UIoFbLWpPvQYLIql6s9tXxS0KJeLgdxLtipzV0fuW/bfaT1V+r/7CZDeCBuSpn3i
 RIStEmc2JUE9rSnMKP8z1uxRRK+aSrJDND/2uHWpSUpF9/55DZZDyDG8+45CjQzMh/HD
 HRbmq+vqNBXYhK60G/I4YHGKNdLNIiqrh8+IHA1ZfTfA8vceCy/xDh1wGb9kTy2JuCkz
 gzJbGaaw/qtQE7knFODLQQ+it1IuAyWh+ymN8W5dm2k2KUvBEvsJ8zp//WtAs3FetfTw
 nRgfPB1Gbk9RzrUSgOCaT74t+zzJwvqxl76fkMa0L+ov5gJ3/Yo9cL/L1PsG9IUqf0Sa
 956Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761584329; x=1762189129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m8UeM8WArxna7YTxUHoHINCBMaN++zqrX8DMKwWVWk=;
 b=mz3b/GFYOeTjdaNbjiOkpbWPZimgn1xxMAyZ6vfcIFaeKRbmce/nARe+PP1P9SccKT
 1dBfai7oEBtUgzP9ZajGEIVXKwuF9G53Ughoiap8pFzlxTkjJ3SxOmZmeFK5SLD2O20Z
 irHGnS4cj7DrEtrZhk87Tno4hXO3X9IVmhfBcnMeYptYzUlHXZYSx0/ZMSgi2dJh3PRm
 qmuTFnx2GIICdEqOwy9X0CksB4A7GHRBU9dTh39VgtxrV5llo3CJ2e/GMftyZqLEukJr
 vkAL5tveDBiZ6Nswmfr5zBEQQ0ZdUunwte133zouh7PsxmJNknLys8BVTQPsi+299TDL
 Zz2Q==
X-Gm-Message-State: AOJu0YzZQwE+6YTdl4lGLyKcIK41iAloTCr2iNxG5+7epOfFxGslRiuU
 oEYy+NQ64fi2iMsmOgDfcoxPlbQrhNPJIiEbOwRVqjJKhcoPB/+zZYWj91foBxfW1wg=
X-Gm-Gg: ASbGnctOiXYclmmOtlPUXxE9DWr4RIPg64rbesvgNID3J/YOOd71oqGC/WJDRTsUD2V
 Yz5XBxhSiYA6ocXgBPba0zDKMM1n0Wj+Jkuvc9oheqZaXA0Vey967YymCCBJif8o8C/1LaIfHxs
 NmBzaE+LWptpVfKc+Zl0BmwQMaVw/Fi6JNFv93iVq8XB0kYmdHWZcYOtw/7ETRIJa2KzYcrDPGi
 rS7oSbrg7IgA2sRDGiLGmx9gv/jIgl9b14ykcrd3PgI/XozkX4Wm/2nNinrzt48pWg7z3tZ8rh8
 3G1+fw0vvJNeTmP5AswkHHQlmKvCLY/bCfpb+n48DDaMz5yyS0iFAR0WdBWtMhKZmIUcf4yZnQb
 UiivPSo5JIy+WVbCyYCLfoVN4qGvhI9tPBO8gT/+UOxUA+g+EYQ7E3UpAcmIhE0dn9uxnKuiAFi
 L2QdaOAws8vRT+4z0q+kvgGbPylkrAJNGq5w==
X-Google-Smtp-Source: AGHT+IGeH7XLwIAeSCnHoTSfBz4hA2mGZ6Mf5wsfhovdRq5i9u2XsHpc7kwwhuRQcbwJwftscWZZoQ==
X-Received: by 2002:a17:903:2f91:b0:27d:69cc:9a6 with SMTP id
 d9443c01a7336-294cb515f4dmr5873075ad.53.1761584329291; 
 Mon, 27 Oct 2025 09:58:49 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498e3d2aasm89575585ad.88.2025.10.27.09.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:58:49 -0700 (PDT)
Date: Mon, 27 Oct 2025 09:58:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Robin Jarry" <rjarry@redhat.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 3/4] net/tap: use netlink if possible
Message-ID: <20251027095847.2a1afb37@phoenix>
In-Reply-To: <DDT8HYDZ6BS5.4UGBB34IPO3I@redhat.com>
References: <20251027153750.445275-6-rjarry@redhat.com>
 <20251027153750.445275-9-rjarry@redhat.com>
 <20251027090642.13524bf2@phoenix>
 <DDT8HYDZ6BS5.4UGBB34IPO3I@redhat.com>
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

On Mon, 27 Oct 2025 17:10:24 +0100
"Robin Jarry" <rjarry@redhat.com> wrote:

> Stephen Hemminger, Oct 27, 2025 at 17:06:
> > Netlink has been available since linux 2.4!
> > Rather than having two code paths, only one of which gets tested,
> > better to commit to netlink and use it.
> >
> > Since dealing with netlink is a nuisance, I wonder if using
> > libmnl would be better. Yes, it creates new dependency but netlink
> > handling has been place with lots of Coverity overruns etc.  
> 
> I don't mind replacing ioctl with netlink calls but adding a libmnl
> dependency just for one driver seems overkill.
> 

There is netlink handling in a couple drivers but probably not worth
bothering for now.
