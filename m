Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F7C36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 08:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A685640DCE;
	Tue,  1 Apr 2025 10:07:26 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 85DBB40A6C
 for <dev@dpdk.org>; Mon, 31 Mar 2025 23:56:38 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso8716688a91.0
 for <dev@dpdk.org>; Mon, 31 Mar 2025 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743458197; x=1744062997; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FaGQRcG+H7dPWvSolmL7xRA/fpyL5BfUY1bsZR4uZqg=;
 b=HbtUuNCwIczDID4oq5s8AH5fOh15UTTQkvvgH9asZ6o+vCb5TjIsKzgr52IN/QbQ1Q
 YHvumrLKCbSx8kXrDVfUzvzI54xkGsoVdO6TXdAQ8XQm7PDrY+hxdpu6I/NEz+FEwOg1
 q7DMtH2DdiLJ8hbn0elWu5Cqnc0SCKg8WLku+Xd/Ti8ItIVTgsUSG7MYb/tdSknPOM/1
 7oXyElEuHdDBLbJ2VNmbF/4pxgPUVXYqHTzftW25Q+zj96UYpnfqxVGclOZezV+YfF7v
 9Vy6Da80XhDWDeFjyITsznT9T2Ul9jW/YCnwgIgufBGyAraNm1rrybbb3HSXb8M/ZqTi
 bQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743458197; x=1744062997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FaGQRcG+H7dPWvSolmL7xRA/fpyL5BfUY1bsZR4uZqg=;
 b=rIQILKSwG08HApCf6KZURE+tC2WTZTYuzc6troTlIkshA3Ei4Tcpq6qzMSapuKLjZC
 /yB+BzbzrcE0US0Oui6E71S23y0UD57UBQlvz5J+b1V4U3SlZGSfoKh3TEX1cMxv4RoI
 1yHC0jWoUvlH1r+2qiggmM1XhR+f29x0MyCOR4VRhovHyMEmJYLrgJssHAhNvMfdqETT
 7r3YGSJeuUWDopRM1KYWmpqhu3VjrVtu68i1RbRD9qGnmLkRd7Q73FmCGG4z8k2wt4bb
 pUbxQruTJ4UBohg2Vvx0ZZLq3r7COeq02z+lGWsEmfwvkOhYCYmcTjIt7KYA5ehHX8TX
 ljfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE7GwXV0N/pMpEOfiyWNvtjVvLZhQO35hT05TfmRKze8pIjxW9wPxngWheZx1lQUYEQLY=@dpdk.org
X-Gm-Message-State: AOJu0YyQI6C7xEVY+TeTce59SFKOexpRwu5UNr5ZB5v2Jc3dGEwAcMit
 9AqC7W8WOxpOCL6JCfEuKQIFcyI9OqrXABEyrlIu2JoApIh98u8uIgUgNy7EzCKkDodv9PPScH4
 tFJlGBQCGnFIbLvtonLH/lSB7y4s=
X-Gm-Gg: ASbGncuiEsDTcVqOE0a/hTjZvKnSYGBK6IYUyluxOwZZjGAXrjMY7DrBQB/+WSiYxUW
 jjgxp5tpSY2TlPNg0vCRo9dWjUVPrly5eEgNf316nEl67TjGwwy/uyachrftKOWw4e+jflDkxaS
 +Iy8YVJIQnwu/rYVFKTJa0WFqc9OGi9wFEKoxSS95SWFaHZM9nxXCqVa0JDv4tTmvCoSTy
X-Google-Smtp-Source: AGHT+IHFMToNNDV11cpb2INbLN01hPw/9sQK8nfTa5Yil0xdAhZgPYOVxWoeioPBr7rzWSARvnXbOJsEO8NJKCPBf5I=
X-Received: by 2002:a17:90b:56c8:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-3053186c83cmr17951872a91.2.1743458197592; Mon, 31 Mar 2025
 14:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250329195333.324178-1-tanzeelahmed713@gmail.com>
 <5791577.oiGErgHkdL@thomas>
In-Reply-To: <5791577.oiGErgHkdL@thomas>
From: Tanzeel Ahmed <tanzeelahmed713@gmail.com>
Date: Tue, 1 Apr 2025 02:56:25 +0500
X-Gm-Features: AQ5f1JosxE9DKfEdz4wR02WaKDkjZTeyVgRZgb3ACHy4QyRLq05B7ER3c2LH77g
Message-ID: <CAPDzQQ5GKePRVgzxPotBvjpzXrrCPjgfGo1mRxnwLX_U55Ezhw@mail.gmail.com>
Subject: Re: [PATCH] examples/flow_filtering: fix make clean
To: Thomas Monjalon <thomas@monjalon.net>
Cc: orika@nvidia.com, dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Apr 2025 10:07:26 +0200
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

On Mon, 31 Mar 2025 at 13:45, Thomas Monjalon:
>
> 29/03/2025 20:53, Tanzeel Ahmed:
> > make clean is unable to delete build directory
> > because *.o files are not removed.

Removing .o files is a simpler fix, as in the patch.

> > The other way to fix this would be to add all the
> > c files into SRCS-y.
>
> How adding all C files into SRCS-y would help?

We can bypass the obj files generation and use the current clean as it is
