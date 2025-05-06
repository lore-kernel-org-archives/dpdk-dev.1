Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884E7C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 14:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE6940261;
	Tue,  6 May 2025 16:12:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 242E54025D
 for <dev@dpdk.org>; Tue,  6 May 2025 16:12:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746540754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIaDD20CTwpLuHKWg+g0h8WqIM/Jh4Wxe84BBKsZSL0=;
 b=CrsKfPf+0OtJJRaP0FGc++MtW/nyBef5P5daV6H7y218Vt3Ky4fnTUkiGMbMlbB3w3hQnL
 3Y1rR3+2TyDBs3MFDwAFDFFbnuwljbiAqLcqqMf6YmR4d2x+Qkb6OqDn6KQGqRYFM6Dyjq
 OpndUg7t2Cx8fL1441/YQim4cIT9Lvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-6T3WD-BpMIy1J-2wqTX5IQ-1; Tue,
 06 May 2025 10:12:33 -0400
X-MC-Unique: 6T3WD-BpMIy1J-2wqTX5IQ-1
X-Mimecast-MFC-AGG-ID: 6T3WD-BpMIy1J-2wqTX5IQ_1746540752
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0FF1800985; Tue,  6 May 2025 14:12:31 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.44.33.241])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDCD11956094; Tue,  6 May 2025 14:12:26 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Patrick Robb <probb@iol.unh.edu>
Cc: ci@dpdk.org,  dev <dev@dpdk.org>,  Ali Alnubani <alialnu@nvidia.com>,
 "Brandes, Shai" <shaibran@amazon.com>,  zhoumin <zhoumin@loongson.cn>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: Re: Polling for patchseries in DPDK - the /series/ and /events/
 endpoints
In-Reply-To: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
 (Patrick Robb's message of "Mon, 5 May 2025 12:08:37 -0400")
References: <CAJvnSUDfGsKk0c7Mk9jsRMxh4wO6M32quitrnkDPWHHiTZEiCA@mail.gmail.com>
Date: Tue, 06 May 2025 10:12:23 -0400
Message-ID: <f7tzffp7rqw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yGv5ImfKVfpGc7sA-90Ry38mX7yynAlVv2WWeFx6i_I_1746540752
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

Patrick Robb <probb@iol.unh.edu> writes:

> There was some discussion at last week's CI meeting about usage of the Pa=
tchwork
> /events/ endpoint for polling for patches, and issues with that process. =
Here is a relevant
> blurb, explaining some issues Aaron has run into using the dpdk-ci repo "=
poll-pw.sh" shell
> script:=20
>
> ----------------
>
> * Discussion pertaining to looking at polling for series using the events=
 API. This events
> endpoint (with series created event) returns info that a series has been =
created, but returns
> a limited set of data in the payload, and this necessitates a followup re=
quest to patchwork.
> So, this seems like it would actually increase the amount of requests mad=
e to the patchwork
> server. Some related issues discussed are:
>    * You cannot query the events endpoint for only events from a particul=
ar project (this
> matters for patchwork instances with many projects under them). For DPDK =
there are only 4
> projects under DPDK patchwork, so it=E2=80=99s not a huge deal, but still=
 a small issue.
>    * The datetime that the series-created event returns is the datetimes =
of one of the
> commits in the series, not the datetime of when the series was submitted.=
 So, this means
> that if you amend a commit (this does not update commit datetime) and res=
ubmit a
> patchseries, the datetime on the series-created record will not be =E2=80=
=9Cupdated=E2=80=9D. This can cause
> us to miss series when polling via the events endpoint.

Sorry - I think there is still a misunderstanding here.

The datetime for the /series/ endpoint is what is provided in the patch
(so could be not updated)

The datetime for the /events/ endpoint is when the event fires (that is
when the series is received).

I can reply to the meeting minutes document with this as well.

> ------------------
>
> And for context, poll-pw.sh will check the /events/ endpoint for new seri=
es created events
> like so:
>
> --------------------
>
> URL=3D"${URL}/events/?category=3D${resource_type}-completed"
>
> callcmd () # <patchwork id>
> {
> =09eval $cmd
> }
>
> while true ; do
> =09date_now=3D$(date --utc '+%FT%T')
> =09since=3D$(date --utc '+%FT%T' -d $(cat $since_file | tr '\n' ' '))
> =09page=3D1
> =09while true ; do
> =09=09ids=3D$(curl -s "${URL}&page=3D${page}&since=3D${since}" |
> =09=09=09jq "try ( .[] | select( .project.name =3D=3D \"$project\" ) )" |
> =09=09=09jq "try ( .payload.${resource_type}.id )")
> =09=09[ -z "$(echo $ids | tr -d '\n')" ] && break
> =09=09for id in $ids ; do
> =09=09=09if grep -q "^${id}$" $poll_pw_ids_file ; then
> =09=09=09=09continue
> =09=09=09fi
> =09=09=09callcmd $id
> =09=09=09echo $id >>$poll_pw_ids_file
>
> -------------------
>
> But, as was discussed at the meeting, once you have the series ids, then =
you need to make a
> followup request to /series/{id}.
>
> UNH has a download_patchset.py polling script very much like poll-pw.sh e=
xcept that,
> because we store extra info about our processed patchseries in a database=
 (to facilitate
> lab.dpdk.org filtering functions), we use our database to get the most re=
cently processed
> patchseries, instead of the "since_file." Our process (running every 10 m=
inutes from Jenkins)
> is like this:
>
> 1. get the "since_id" from our database
> 2. get the "newest_id" from
> https://patchwork.dpdk.org/api/events/?category=3Dseries-completed. Get t=
he [0] index of
> the json response (the most recent patchseries) and save that series id.
> 3. for seriesID in range(since_id, newest_id): get patch from
> https://patchwork.dpdk.org/api/series/{id}.
>
> So, both poll-pw.sh and our UNH script follow the process of making a req=
uest to /events/,
> and then followup requests for /series/. Thus the total number of request=
s being made on
> patchwork is (number of new patchseries + 1).
>
> -The most consequential difference in the two implementations is that pol=
l-pw.sh makes a
> request to /events/ with the &since=3D${since} parameter, passing in a si=
nce datetime, and
> UNH does not. As Aaron explained at the CI meeting, because the datetime =
provided in the
> /events/ payload is not what one would expect (it gives the datetime of t=
he commit, not
> when the series was submitted) this means that poll-pw-sh can miss series=
. With the UNH
> lab polling script we don't have this issue because we don't make use of =
the since
> parameter in our /events/ request. I think the options for poll-pw.sh goi=
ng forward would
> be:
> 1. Update patchwork so that the datetime provided in the /events/ payload=
 is what is
> "expected" i.e. the datetime that the series was submitted at.

That already is done.

> 2. Adopt the UNH process of discarding the &since=3D${since} parameter, a=
nd rely solely on
> tracking the most recently processed patchseries id, get the newest patch=
series id from
> /events/, and traverse the range of (since_id, newest_id).
>
> -I agree it makes sense for /events/ to support a "project" param.
>
> Thanks Aaron for raising this conversation. We can continue the conversat=
ion over email, or
> also in person at DPDK Prague!

Let's keep discussing.

