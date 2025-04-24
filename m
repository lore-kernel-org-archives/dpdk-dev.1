Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB76EC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 12:31:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FEB340395;
	Thu, 24 Apr 2025 14:31:58 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 1BB44400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 14:31:56 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1088717a12.2
 for <dev@dpdk.org>; Thu, 24 Apr 2025 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745497915; x=1746102715; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hVfPSfhlUzRP8lma88TFUYpygoIfn96KDK6JZxshTvg=;
 b=NijgISFbgrQo75Da3QX1cS16tbiioVwFt4+RRBXFuxammZtMuD3Ad9q/nuwdBRxZMY
 1b0ohQvOLxTVYdtLykl8vfS88gw3vAgPAEbMdVjRIA/H3raJvrq5kJkb1KGnzgUReWIT
 LEKtj1eIo9etvu22Ehvf5NfNNgihKvBvAVhNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745497915; x=1746102715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVfPSfhlUzRP8lma88TFUYpygoIfn96KDK6JZxshTvg=;
 b=q5PjXHCVrrBEGJedaJM29QOUtWpdfpBRPHJPZvW4gxQ5WaIwS7Igh6G9uHg6DAD59b
 0eu2uA9UhjwJy8Z5J9G5tlhtJVD7w8GzyQCqzDrKp5oqskrHB3gf07yP6PTAtSdixwy4
 ZEMhouAfAdJ3ZVJUhrOilM07bfKGTILexdKzMLirLXpJ44N+NUP0bSkUbtOJk2gb3flo
 jAs/9mq1/74gXuUwP8YWdJksfE/wxBsJYNKPtU2rvuHvPA/mxXNk7wpa6+z6U2oYr4um
 2SUEgoj6vuapUhtY2+ha0NuVzZUxP269v6EehEWNp7nLHyzNQyXDhrD0BnlZtocgDUJn
 ZHyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuQZMCqZSSX2cqv+bDEBYmDQTNu6kuxilnHOoy7/Bo9mGs3l62a914uC3iOKW8Njp7pBQ=@dpdk.org
X-Gm-Message-State: AOJu0Yxtf9NRnslmGyFMRl+UiDQgfdFCY699AwfykVt1GUvKwVDnxRKl
 4AoueMfOAgPZsykS4OZQwu4uzi75tYpINdFPpoj1j9eQ4DqkALjBz108I8ArgvMTrNAAADu3+iQ
 9K7+yW1y8lkEPOiYA9XntrQIFEVPZhf/dQXrvtg==
X-Gm-Gg: ASbGncuxdV2Y/ZpwaUh6lLuT9R0513xpi7OtRrQw3X1PwwGMa4hvIKJg4APKB500COZ
 zz8tpI5m8lzGX+a1SHicajORWSv3d1+mpEB0Q1PZH1P/IjznVi+TTf9FOoQ7EGcu1cRCu7jLyFG
 hBYqEzt+r+8vIQvg+GraSyYHf5yxFxmQcySVuO8PpDWr1Gd92u6sI7aag=
X-Google-Smtp-Source: AGHT+IEWPdKgiHLUSxe/U8WsPViRC7Q9da7MGVO/vw3Sozw8mAHA5bZ8qxduct466ceF+mLZA5l7azfO9IzlOU0fogw=
X-Received: by 2002:a17:90b:5685:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-309ed272b2dmr4326909a91.14.1745497915100; Thu, 24 Apr 2025
 05:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
 <20250220212443.66483-2-dmarx@iol.unh.edu>
In-Reply-To: <20250220212443.66483-2-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 08:27:33 -0400
X-Gm-Features: ATxdqUEnBBnqXEDOvLG4oHiQA-sCyfJc0cmx6ogf2Jrk2Vp29pJjrz40-mh4Gjc
Message-ID: <CAJvnSUDvKLn0xs8eGszrvi223oZQpBwCP7cFOfEA4yi+H5NrxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dts: add clearing port stats to testpmd shell
To: Dean Marx <dmarx@iol.unh.edu>
Cc: npratte@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000002fa5d006338567fc"
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

--0000000000002fa5d006338567fc
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks.

--0000000000002fa5d006338567fc
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks.</div>

--0000000000002fa5d006338567fc--
