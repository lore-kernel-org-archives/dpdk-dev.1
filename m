Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D32CC369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 18:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BBA440289;
	Tue, 15 Apr 2025 20:21:41 +0200 (CEST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com
 [209.85.219.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1553E40263
 for <dev@dpdk.org>; Tue, 15 Apr 2025 20:21:40 +0200 (CEST)
Received: by mail-yb1-f172.google.com with SMTP id
 3f1490d57ef6-e6deb3eb7dbso4782156276.0
 for <dev@dpdk.org>; Tue, 15 Apr 2025 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744741299; x=1745346099; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RvAzCFbzNwj3NpovjfWu3gg1D+hysibQg6h+q5TqeSI=;
 b=aO+aJsbw/8/1sagk6Y5r9ALaPfnOsdlZkDKPyxM8Wd7s1N3wYY6a7rKxk68qGFs5p+
 W2ZzxqtMg/G+jS/Yb1PsbTKuMk9ve7r5aLVwQDn1BNSWztig+FSCIZCWty2p6TfP/YZO
 aXA+JxGLbrHau83WmbAZ26eADMjnYDei1ptQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744741299; x=1745346099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RvAzCFbzNwj3NpovjfWu3gg1D+hysibQg6h+q5TqeSI=;
 b=sjKyZgjEREVTwM9LflRGdPpAGoL88IeWXohm9uz7fMSK8wrV7kQEunGtOVBO/kyWyy
 5ogyj+WcGLY4h41tzaXdmT7uAzE2366dFCBI/eP5yvCIl/Uz/UiiaZu9wn1o1kOAmC88
 N5xuFZkLhQIvZKge9kuRZCZrPMtFsTvimyg+L8mW7KacF9akf2+5nzO2P/aw548YU2nr
 BuW9EAvAC34EJdpBmZsoj3LZ6TNUqT4yDiM+B5KeuY4+anDfA2xnHozWAIiXhO73qTKa
 wb/rfcdKRB9sioRpuxUUprOVY8IaR+zH2pieWj59ZqJICkz3Jdo/7zJheBT8MDgO1j97
 u6OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyT1b9wxRBjUuNuNFRi4ILTrpGy+p1zJX9k81If3UNIeQGd2ywSVx6eDPZhqM2gINpDLQ=@dpdk.org
X-Gm-Message-State: AOJu0Yy0nX4FNHkx/RBS6QpkthjCe3A0FgHBhpCx5gSeSd9vs10SLBb7
 ZjCsfsHZmgrSaZ9oC1/CL/1sd5mDcl85oqNYYqiCvot43yXcRo7I3qAH0/gUOg9gjnZYhKFCT/Z
 nTPFoV8YzivFYRWeAAy6HYsiqDR+0beL7MkO31Q==
X-Gm-Gg: ASbGncvyGorxPVLbPp1ugVOMOasJFP643jI5lLDdN9iarIfok9ibU0Xv4u1CmNTJvgR
 3bVln1VTt5ufx5PsIDDbC2gXAWKTTw9zld8NiApkyLZdpCv74+Qf3LhuSZX54LNqhOWqrtrp+Nd
 dVE5ZArtob9G5FQtJX6gEVcRxrFjiEp3OAxOuYuK+hcKQ2R+bvssONw091
X-Google-Smtp-Source: AGHT+IEa2C9B9eje5b2L256t5bfrN3i05acq6wdJcp+f7c4zrzkK5/ha6qJUulOlIm7AYva6Ln7KqWAAmhPL5JIMYwM=
X-Received: by 2002:a05:6902:e03:b0:e6d:f516:56a9 with SMTP id
 3f1490d57ef6-e726e766906mr382222276.25.1744741299170; Tue, 15 Apr 2025
 11:21:39 -0700 (PDT)
MIME-Version: 1.0
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 15 Apr 2025 14:21:27 -0400
X-Gm-Features: ATxdqUEZ7YKTNC5FZ--U-bopufh4Bet8H5GiuWzwYMGEumXJZVuaSLOJJySKX_8
Message-ID: <CABD7UXNy9yymZ0+4SfHJ9tcA9ibg1rfph8Ee1tkgPxsbJwtaGw@mail.gmail.com>
Subject: Flow API Test Suite Inquiry
To: orika@nvidia.com
Cc: thomas@monjalon.net, dev <dev@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>, ajit.khaparde@broadcom.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Ori,


I work at the UNH-IOL DPDK Community Lab, and I am writing an rte_flow
test suite to add to the DPDK Test Suite.


The flow API allows for an extremely broad set of rules to be created.
My understanding from my first pass at writing the test suite is that
there is a small subset of those rules that are =E2=80=9Ccore functionality=
=E2=80=9D
that the flow API aims to support, and there are also rules which
technically can be created, but may not be supported by the main PMDs
and/or may not be useful rules that people want to see tested.


For instance, I am pretty confident that a rule like the one below is
one which the community will care about, and which PMDs will support:


flow create 0 ingress pattern eth / ipv4 src is 192.168.0.1 / end
actions drop / end


But I do not know what is the full set of rules that I should be
validating from a DTS testsuite. Is it possible for you (or anyone
else on this mailing list) to provide some feedback on what rules are
most important and I should include in my test suite? If I can get
that feedback, I will draft a test plan and share it back on this
thread for community approval before I write up and submit the DTS
patch.


Thanks for your time,

Dean Marx
