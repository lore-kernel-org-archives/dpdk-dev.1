Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F980CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 19:58:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A373402D3;
	Mon,  8 Sep 2025 21:58:22 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id C5FA240264
 for <dev@dpdk.org>; Mon,  8 Sep 2025 21:58:21 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45de6490e74so13202015e9.2
 for <dev@dpdk.org>; Mon, 08 Sep 2025 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757361501;
 x=1757966301; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74H3fJ8OaAKwAyallhh4fw/96duCy16Hpk+dSgWfzSk=;
 b=o5T/ULPcjRiPVrMoxh5X9YceH4Vy+6dhzk6wdHFHfDbhd4ydMXiQ2RwEu6+rL0+feH
 ruwCfRASFL6Xwca64D1yp+7PDIkOyZDYOVUYtjf293sb+BQj00bwgiZSfZPx1UFNdiaw
 +QqXpqqHOhs9HonIzlGpbWUw9h0Sow65zzcXLIwpxMBJdvZ8OETS0GKBKC4+h/0IxpxA
 3G56sjz8uv+jKWl0dMAxkZePiosfdrqj2KFJ+gB857P3zHF6w6DXX7RFihwPHrqIv1Xr
 Y9yQGL+sJ8635mLMM2vzwam+T+2X1IISEgiMwOmV9+wi4NTVIzAdI63TugU0rwwKWRDL
 zgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757361501; x=1757966301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74H3fJ8OaAKwAyallhh4fw/96duCy16Hpk+dSgWfzSk=;
 b=AmSMr/nCuSvD2t8CzSp3xdt1c/HwpxY7VtOqxUVQrX4usH1CIwJYNWSTHRzVec/SLg
 G1hy6yhjyEZuKrFDDSPLwiObmPy/eAJEPxwRcoqCusn9ugFJ2Rb2V/qvf4uuYqgncRqq
 a8Jr0GaJDUeaWnPqZjQmbEW6UUdidXk117JmjEUhJyA0b8lQniY+9tPkz1u/s5eaN7v1
 Xb20PMJUf+oW/PYxERQfQ3tZ4XuX/RCUcLNPS5Op6aYCUfHMyfOWfNApW31Lzpys0wHX
 LKx8YIZ94zgWzs+/+vH54NBbwR7Cnu6g9nfvSZI0VoLRmOyoooL9PV7WrolFKdgCzjaU
 1//A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVZyUXXBcms0Ti3Qh7EH0CaBnLXOeD8aP1z/l0GPLwd9VH1kEw9InaGURia0L2GzMr3eE=@dpdk.org
X-Gm-Message-State: AOJu0YxsOiKqRIi6LXDJWno48PuD3Zq5/gwyitNH8er91qR4wcesRWTA
 BPf8zpW6uU/mOwgbTqPj9ske8FnWoW48NhJPDYhSim+Q4YFx3CleM7gK1XZB3GG9W5Q=
X-Gm-Gg: ASbGncuvEQPItNKP0Co2bQCsY4zOJU0NdVLxYTIwFpyw3YCbhCYS9jOU4rKmU7VqPX3
 YgV/JcrWW/VgnY4W+vCbDk8TaK/CSBfjphShhwZeZ5xLUD/dMBaELmMeca03zYFMtZj0UXdtehC
 zuyUHTLjEy5tc8YMzaV3wnfPHvVQur29TjgwiI3huLshCpmS/KEn5NeXeuKI6CIClqtv3pzlh62
 Nkt0CiajUr5tjo3n/h/oycRsr4OhzGr6xmAqDl26QgChFrP/PSrIO/EO/PPDsrYvGXBkf0u8yyy
 NnhsgxEWE3JQz5frtAhVrv8yg299IVfe99AvNwTDT+MkYd6xQW7CxiCXPmimErLvgl+CMsvDgcm
 EyL+IlBNSu5E3m45+FYPAtdo2eyAn364MHSo9mbtM9VF7yYKSq3eI6DDrfDVPK15DFuv1wg4Vd/
 A=
X-Google-Smtp-Source: AGHT+IFoVBl5pRUTe+1Lst01ChPsTqE/xeL9b/m/InWHDk416aX5wRSW6PsqPuZRznw8/5X0kUjTYQ==
X-Received: by 2002:a05:600c:4f56:b0:45d:ded8:3b6e with SMTP id
 5b1f17b1804b1-45ded93698cmr90065e9.17.1757361501077; 
 Mon, 08 Sep 2025 12:58:21 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e5100eba33sm11829516f8f.9.2025.09.08.12.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 12:58:20 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:58:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dengdui Huang <huangdengdui@huawei.com>, dev@dpdk.org,
 lihuisong@huawei.com, fengchengwen@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH 1/3] net/hns3: fix inconsistent lock
Message-ID: <20250908125815.3dbbfaa0@hermes.local>
In-Reply-To: <3368264.aeNJFYEL58@thomas>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250813073317.1352274-2-huangdengdui@huawei.com>
 <20250813140646.48a2ff16@hermes.local> <3368264.aeNJFYEL58@thomas>
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

On Mon, 08 Sep 2025 13:53:38 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> 13/08/2025 23:06, Stephen Hemminger:
> > On Wed, 13 Aug 2025 15:33:15 +0800
> > Dengdui Huang <huangdengdui@huawei.com> wrote:
> >   
> > > The hns3 driver supports configuring RSS through both ops API and
> > > rte_flow API. The ops API uses spink lock, while the rte_flow API uses
> > > pthread mutex lock. When concurrent calls occur, issues may arise.
> > > This patch replaces the lock in the flow API with spink lock.
> > > 
> > > Fixes: 1bdcca8006e4 ("net/hns3: fix flow director lock")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> > > ---  
> > 
> > With that mutex removed, you can also go farther and remove all references to pthread.  
> 
> This patch was (probably by mistake) in the next-net/for-main branch.
> I've dropped it when pulling in main.
> 

I went ahead and fixed the original patch to drop pthread references
and fix wording in commit message; and put it back in next-net.
