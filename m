Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6F7CD8CA7
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 16:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65387402A0;
	Thu, 13 Nov 2025 17:41:08 +0100 (CET)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46]) by mails.dpdk.org (Postfix) with ESMTP id 4EF8840151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 17:41:07 +0100 (CET)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7c701097a75so554539a34.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 08:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763052066;
 x=1763656866; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHtMwNJdm9f5UDv3qTUAA0azMDa5PZvwRU5ZYcnwsHI=;
 b=hNln9U4O6B4jZoh8vlzsSFKcRNyt+blufFZEEteU4wMN8QGVe0zfP6X4HnRO3KJ2LU
 HD6bSVInlLa5C37nNvKL+TtRgHv8g5P36NmlsyxzxaKF9ZjUgd7zi9ItoEsOXbDnx3gT
 5b40lDLAbYqCwyA3WOaqa0wr31QNYJMTOemzSIdyHRvIK6cyiZdGWlgRj1PZ/u9z3Dln
 V3r7U4tYLhJv4bHXrFVCibNddiepsesrkaHQxs7Jz2Cmxc+yTAVDucNeRCh07tTXXGvZ
 cA6zRF78tcv2wnukMs5gvkcJojtipSPI5fWdn1HteBhkxJYwUdKzL7AHo0WRYHDRj7c0
 tnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763052066; x=1763656866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kHtMwNJdm9f5UDv3qTUAA0azMDa5PZvwRU5ZYcnwsHI=;
 b=IbpS8eYi5NhQhrXvaDfP41Jg9RNVD2YpwBHOMpk+oQN7IB0gOMr0cK3lcqtY/1dhsx
 2iRgc1/3dfaWhby/3ZxMR+JzQaZkETOWsnANMim3IXSN0En4fhnFkSzUPr5BWVqM1qDE
 8Trm2L180azPSBBSp/C2fT6yqVJ/iTOHhNzY+c/d9+E6NG2+cKRpAs3RwBBfAGph5/ah
 bJP4GVf54x1EZt84a8yAHLkGvfaroxpPRs3QA8NKtDdW78+fYPkiMYgWDrgpvb4rbjwV
 WiVfHkEUtvfoTXL0jIrIIqAXDZIn1Mzvb8j6riBaSZzkN2budQt3ZnZQZqm9Tytdnjoz
 7D+A==
X-Gm-Message-State: AOJu0Yymh5+r6U1v7k0vbcWqN1J0pT4qU1XsNBfJW3jsaX4nEfMvUlqh
 Hqw0L/OoBHJfx/mPsQj+7q75AKhmgIxO+duVAGWYT3u5J+aN4OSPt+ZmnldZfw9CezU=
X-Gm-Gg: ASbGncutKem4aD0mXImdlOvI5VcCIGcVtOqUYkrufNNSc9MgvcdcpeBCOO/aEK8pEXW
 RZESKYVhH8TXKt3OVPKqkQwBJW/nOOyTbhmd+RATGoaQxdi+s04CKNvitqC+mvvjV53TFp7RwwF
 3m+KZhIXQXMHVvPWf0fI+4jciCr4UZUk6+kuFypz0bkr/KxxLDwjNcT1F163NFj2n/M65syqz/Y
 WiqCYR2aFUaZ1f5JADxKtVqz0LtB4rE6hI3zX45OyjWBgk3HXIjNgSulCpUuS8mEn8mFz/+M8mo
 Uk+UT+chfv/E79XgUGARkjv34yo6/cJfiGgKVyZOVFfAGR3kjIJ9GTFcsBszW6FWRsSgEQ3y0yP
 FPzFuxYwvkSnUu2/vJ7k36TRFOp0aGw2v0orIAAwd78gBO/Vwez3s1lGIX6cC4u5yN6LW46Nn24
 8Vzmf+mBHBIM48/qrjbU0gyUvzS+kU1Y6txKUU8bR9XWpA
X-Google-Smtp-Source: AGHT+IFsY7zUr7yM7gosXvY86kbaPTTb7HIUDE0aXkpoJDUa6klPwU+NV97+phDhUysWgZtnLjoopA==
X-Received: by 2002:a05:6808:1446:b0:450:730e:d126 with SMTP id
 5614622812f47-450745d87f6mr3348464b6e.60.1763052066218; 
 Thu, 13 Nov 2025 08:41:06 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a555527sm1225760b6e.7.2025.11.13.08.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:41:05 -0800 (PST)
Date: Thu, 13 Nov 2025 08:41:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v4 1/2] ethdev: make representor parameter more explicit
Message-ID: <20251113084102.2ebda214@phoenix>
In-Reply-To: <20251106055246.360824-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251106055246.360824-1-getelson@nvidia.com>
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

On Thu, 6 Nov 2025 07:52:44 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> The current format for a port representor parameter is
> '-a DBDF,representor=pfXvfY'.
> That parameter syntax describes port representor relative to
> PCI device DBDF.
> In that notation VF Y belongs to PF X and PF X is relative to DBDF.
> 
> The syntax 'pfXvfY' will probe 2 port representors: PF X and VF Y.
> If we want to refer only to VF Y related to PF X, the parameter must
> be '(pfX)vfY'.
> In this case only VF Y representor will be probed.
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>
> ---

Both patches queued in next-net
