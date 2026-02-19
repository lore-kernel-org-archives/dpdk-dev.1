Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0AFE9A057
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 19:00:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7774402C6;
	Thu, 19 Feb 2026 20:00:22 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id CAA98402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 20:00:20 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-89549b2f538so33443196d6.2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 11:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771527620;
 x=1772132420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FyTdmqdakhhMOYgzIxbtbfC29SdZAwv4kNZ6wl8QS0=;
 b=U7vOC7q86wwCCFax+rCC//hcZA44wkaABFKyK6XHSfhaWlPr4jLc18HRyTrCyLZG3Y
 CbWEvPWep6dHLqnmS2xx7ACZh007ivBOHHBP9tK5tKbI8+aBpZGHTENJRbUiJcDXUxm6
 Wcb1VoYWFCQMkCTWOXf8SxppdTcHCcFa2Bh5ZvonxcD67Lo+tSZRRjPZXCePEwaQaGPp
 n85Ola4wgZjyObuoSh9BVFg+7O2ikkOAK/zkQhYWPy91Taq4hcwRSGZUb1iMGAZIRJWK
 3T5o5WraQCjvvtBkoN1qypnnyvuKOql2D09t6NbUY2tgh9QDA9XSeEJg6caMiuv7aOt0
 QtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771527620; x=1772132420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9FyTdmqdakhhMOYgzIxbtbfC29SdZAwv4kNZ6wl8QS0=;
 b=uNwimF7bTt0cdaPOxXG/Gd8Giv0TYicDkRPa2GSRJg/WWd1rsfL4xudT5qYdAQ+Pq6
 yOvULGMeknmcfuAzP2xJ4cBrBiBXif0Zk2/r6AvqpeAIAopUTxTkIi8Aegx2Uwpe0tZn
 D/Ao8zW1uI5BvZ/w6oNZ251OGkVSK/8sTLsnjdReVHfrJEBvUMJcWVOjKhCk+AaVF1Ri
 Z0JUJM9gpAXF1rzb5/9SpHd7ZEKClll7112lXaejimYiofxYqSVy0eFJueIKpQPyLebX
 nyCSAbbQq4DphXQEKUJxDmR0d9OOu0oiyqWyRJi+sGk2MdtOr2NPVto/yGLjSwk6atLq
 PFjg==
X-Gm-Message-State: AOJu0YxqvZRwJhBZA2exc8n/98rmnfzqtSkgtER3CWiBPDU+thQZ7buj
 TjNoCw+aUlz1jAEB1/Y0bMDV9gN9g0Gl/JnnLgEh1njk2pwtLUxeiqOqGmzrc87/rWtLp18xXoT
 7CW56
X-Gm-Gg: AZuq6aICyjW3XPbJNpG9zd7fnZGUF0ird0f0VWjx9kFOhoZgAnCV1Pi0knc2hz5gqkm
 HQtzoOPkcCp2m+iwLvbOp7qfpJqvMO3zqnnbuAvX6FFUwgdl0205t9JQfrTgkjZw3W0AnBAfQQm
 0t/6i+LJD9hUADKaus7g/JIkwAe0ad5DoLmssxjNkWxY3Rb1TI/oSnE/x9kCYPriZ+HS2QWuFL0
 lBheMN90KVaN7bSwhO+lyh1AP8H8TZCNxObsDPofo6Y6Jw+xN+of2Vz6P32yEetg0gjsrlaQqC0
 C4KgJb/qt0CE2crFwDA+Esl40HWT1mXgv6EcRSwvZowvnTgBixKmBF7XxYM41DWpTFMm1fYBGpS
 bJw6bOm4OJrBYyCWo9GFOnxPw4xwu9uduK6ojNeo2io+yHlYdnZCFIS0oWYMbDdocNWarpsES4J
 Wiziyp4HNftSyVL+OqTeic4WZ+1M+bdaEjTN537VYkptzUQE4O3+xNuiU7puM4l4cn
X-Received: by 2002:ad4:5cc4:0:b0:895:1c9d:ba0c with SMTP id
 6a1803df08f44-897402c94admr317378976d6.4.1771527619651; 
 Thu, 19 Feb 2026 11:00:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdd1541sm225094366d6.49.2026.02.19.11.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 11:00:19 -0800 (PST)
Date: Thu, 19 Feb 2026 11:00:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Message-ID: <20260219110015.142bcdd3@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6572C@smartserver.smartshare.dk>
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <20260219004449.114564-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F6572C@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 19 Feb 2026 08:20:44 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > + * If a packet cannot be transmitted due to an error (for example, an
> > + * invalid offload flag), the driver must still consume it and free
> > the
> > + * mbuf, rather than stopping at that point. Such packets should be
> > + * counted in the *tx_errors* port statistic.
> > + * =20
>=20
> Looks like v1.
> Please update with my feedback.
>=20
> -Morten


Thanks missed that in re-edit
