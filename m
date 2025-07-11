Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC6C8303C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 12:25:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB2F4064C;
	Fri, 11 Jul 2025 14:25:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5596D400D6
 for <dev@dpdk.org>; Fri, 11 Jul 2025 14:25:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752236734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5NWjlVgwGD/hsqkKO7DtDIYT5XXHwuipUj/Uqpk0Yw=;
 b=FbXeNq+f024klspeaQgubNnvPOU9aBNzn11UeecX5QOyuTPOEFC4/zt1hJtUdZ6oMRc0Y4
 R6VZ15F9EsaNp+x21kwukKtV0nJ+NbLAV2xXcCFWmQXefbMEtRZzXQzsPf1ET1szEqsU4F
 2EbjHStGa4FodH62zZb3PLgZ8Iqy7u8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55--MNS7WWpPJ6tfHVBUttiwg-1; Fri,
 11 Jul 2025 08:25:29 -0400
X-MC-Unique: -MNS7WWpPJ6tfHVBUttiwg-1
X-Mimecast-MFC-AGG-ID: -MNS7WWpPJ6tfHVBUttiwg_1752236728
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87D7218002E4; Fri, 11 Jul 2025 12:25:27 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C740C195607A; Fri, 11 Jul 2025 12:25:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adam Hassick <ahassick@iol.unh.edu>
Cc: Patrick Robb <probb@iol.unh.edu>,  ci@dpdk.org,  dev <dev@dpdk.org>,
 Ali Alnubani <alialnu@nvidia.com>,  "Brandes, Shai"
 <shaibran@amazon.com>,  zhoumin <zhoumin@loongson.cn>,  "Puttaswamy,
 Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: Re: Polling for patchseries in DPDK - the /series/ and /events/
 endpoints
In-Reply-To: <CAC-YWqh58peBbfAMV0TZ+i=dfsApCXKGgMfOV3LbvX-H4gtS-w@mail.gmail.com>
 (Adam Hassick's message of "Thu, 10 Jul 2025 16:11:41 -0400")
References: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
 <f7tzffp7rqw.fsf@redhat.com>
 <CAJvnSUBh+8--cnqXDtLChD+iK8s98g+t=Hi4x-HEa8iH6fpUiw@mail.gmail.com>
 <CAJvnSUDvPZJvqsiy2J4a-b2i0f-BukJiZt61s6PR55vDh99YzQ@mail.gmail.com>
 <CAC-YWqh58peBbfAMV0TZ+i=dfsApCXKGgMfOV3LbvX-H4gtS-w@mail.gmail.com>
Date: Fri, 11 Jul 2025 08:25:22 -0400
Message-ID: <f7tikjyoqx9.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DeT1-npl6vam7jdMEQPaIbO3l9h59Ss9wQJKw95Ea4A_1752236728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

Adam Hassick <ahassick@iol.unh.edu> writes:

> Hi All,
>
> It appears that there already is a filter for projects for events, but
> the filter is configured to be hidden from the HTML view for some
> reason. We don't need to make any code changes to enable this feature.
> See here: https://github.com/getpatchwork/patchwork/blob/stable/3.2/patch=
work/api/filters.py#L239
>
> If you visit the following URL:
> https://patchwork.dpdk.org/api/events/?category=3Dseries-created&project=
=3DCI
> You can filter for series created events by project. This query
> filters for series created events for the CI repo's project.

Thanks Adam - I was using the html view to discover the REST details
rather than looking at the filter setup.

> Adam
>
> On Fri, May 30, 2025 at 12:07=E2=80=AFPM Patrick Robb <probb@iol.unh.edu>=
 wrote:
>>
>> I went looking through recent series on patchwork and I think this
>> is a good example of the timestamp condition:
>> https://patchwork.dpdk.org/api/series/35145/. Looks like the
>> original commits were made on April 18, then the newest version was
>> submitted on May 5 but the series record retains the 4/18 date.
>>
>> And I see that there is no project filter provided by the /events/ endpo=
int. https://patchwork.dpdk.org/api/events/
>>
>> Adam, would you agree the project filter for API requests is pretty low =
hanging fruit? Seems like a common sense improvement to me.
>>
>> On Tue, May 6, 2025 at 3:08=E2=80=AFPM Patrick Robb <probb@iol.unh.edu> =
wrote:
>>>
>>> Thanks for the clarification regarding the datetimes. Yes let's clear u=
p any remaining questions offline at Prague. :)

